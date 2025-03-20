package com.example.Online.Memo.controller;

import com.example.Online.Memo.entity.timeSlot;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class MeetingSchedulerController {
    private final List<timeSlot> timeSlots = new ArrayList<>();


    @RequestMapping("/meetings")
    public String organizeMeetings(ModelMap model) {
        if(timeSlots.size() > 0){
            model.addAttribute("meetings", timeSlots);
        }
        return "organizeMeeting";
    }

    @PostMapping("/calculate-meeting-time")
    @ResponseBody
    public ResponseEntity<Map<String, String>> suggestMeetingTime(@RequestBody List<timeSlot> meetings) {
        if (meetings.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "No time slots provided"));
        }

        System.out.println("Received time slots: " + meetings);

        List<timeSlot> utcSlots = new ArrayList<>();

        // Convert all time slots to UTC
        for (timeSlot slot : meetings) {
            String userTimeZone = slot.getTimeZone();
            ZonedDateTime startUTC = convertToUTC(slot.getStartTime(), userTimeZone, slot.getDate());
            ZonedDateTime endUTC = convertToUTC(slot.getEndTime(), userTimeZone, slot.getDate());

            utcSlots.add(new timeSlot(startUTC.toString(), endUTC.toString(), "UTC", slot.getDate()));
        }

        // Find the best meeting time in UTC
        timeSlot bestSlot = findOverlap(utcSlots);
        if (bestSlot == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "No overlapping time slot found"));
        }


        String startTime = bestSlot.getStartTime();
        String endTime = bestSlot.getEndTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String date = bestSlot.getDate().format(formatter);
        String startTimeString = date + "T" + startTime + ":00";
        String endTimeString = date + "T" + endTime + ":00";


        ZoneId currentZone = ZoneId.systemDefault();

        ZonedDateTime finalStart = ZonedDateTime.parse(startTimeString + "Z").withZoneSameInstant(currentZone);
        ZonedDateTime finalEnd = ZonedDateTime.parse(endTimeString + "Z").withZoneSameInstant(currentZone);


        formatter = DateTimeFormatter.ofPattern("hh:mm a");

        String formattedSlot = finalStart.format(formatter) + " - " + finalEnd.format(formatter) + " / " + currentZone + ", " + bestSlot.getDate();
        return ResponseEntity.ok(Map.of("meetingTime", formattedSlot));
    }

    private timeSlot findOverlap(List<timeSlot> slots) {
        if (slots.isEmpty()) return null;

        // Sort slots by date first, then by start time
        slots.sort(Comparator.comparing(timeSlot::getDate).thenComparing(timeSlot::getStartTime));

        ZonedDateTime latestStart = ZonedDateTime.parse(slots.get(0).getStartTime());
        ZonedDateTime earliestEnd = ZonedDateTime.parse(slots.get(0).getEndTime());
        LocalDate earliestDate = slots.get(0).getDate(); // Take the earliest date
        String targetZone = slots.get(0).getTimeZone(); // Default time zone

        for (timeSlot slot : slots) {
            ZonedDateTime start = ZonedDateTime.parse(slot.getStartTime());
            ZonedDateTime end = ZonedDateTime.parse(slot.getEndTime());

            // Update latest start time
            if (start.isAfter(latestStart)) {
                latestStart = start;
                targetZone = slot.getTimeZone(); // Update timezone to the latest start time slot
            }

            // Update earliest end time
            if (end.isBefore(earliestEnd)) {
                earliestEnd = end;
            }

            // Update date if necessary (take the earliest date)
            if (slot.getDate().isBefore(earliestDate)) {
                earliestDate = slot.getDate();
            }
        }

        if (latestStart.isBefore(earliestEnd)) {
            // Convert to target time zone (if necessary)
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm"); // Use 24-hour format
            String formattedStart = latestStart.format(formatter);
            String formattedEnd = earliestEnd.format(formatter);

            return new timeSlot(formattedStart, formattedEnd, targetZone, earliestDate);
        }

        return null; // No valid overlap found
    }

    private ZonedDateTime convertToUTC(String time, String zone, LocalDate date) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm", Locale.US);
            LocalTime localTime = LocalTime.parse(time.trim(), formatter);
            ZonedDateTime zonedDateTime = ZonedDateTime.of(date, localTime, ZoneId.of(zone));
            return zonedDateTime.withZoneSameInstant(ZoneId.of("UTC"));
        } catch (DateTimeParseException e) {
            System.err.println("Error parsing time: " + time + " in zone: " + zone);
            throw e;
        }
    }


    @RequestMapping(value = "add-meetings", method = RequestMethod.POST)
    public String addTime(timeSlot timeSlot, BindingResult result, Model model) {
        if(result.hasErrors()) {
            return "add-meetings";
        }
        timeSlots.add(timeSlot); // Pass the updated list to the model
        return "redirect:meetings"; // Return the same page with updated time slots
    }

    @RequestMapping(value = "add-meetings", method = RequestMethod.GET)
    public String showAddPage(ModelMap model,@Valid timeSlot timeSlot){
        return "add-meeting";
    }

    // Remove a time slot from the list
    @PostMapping("/remove-time")
    public String removeTime(@RequestParam String startTime, Model model) {
        timeSlots.removeIf(slot -> slot.getStartTime().equals(startTime));

        model.addAttribute("timeSlots", timeSlots); // Pass the updated list to the model
        return "organizeMeeting"; // Return the same page with updated time slots
    }
}
