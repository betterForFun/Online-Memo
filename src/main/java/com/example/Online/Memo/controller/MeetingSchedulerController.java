package com.example.Online.Memo.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("/meeting")
public class MeetingSchedulerController {

    @PostMapping("/suggest")
    public Map<String, String> suggestMeetingTime(@RequestBody List<UserAvailability> availabilities) {
        List<TimeSlot> utcSlots = new ArrayList<>();
        // Convert all time slots to UTC
        for (UserAvailability availability : availabilities) {
            ZoneId userZone = ZoneId.of(availability.getTimeZone());
            for (TimeSlot slot : availability.getAvailableSlots()) {
                ZonedDateTime startUTC = ZonedDateTime.of(LocalDateTime.parse(slot.getStartTime()), userZone).withZoneSameInstant(ZoneOffset.UTC);
                ZonedDateTime endUTC = ZonedDateTime.of(LocalDateTime.parse(slot.getEndTime()), userZone).withZoneSameInstant(ZoneOffset.UTC);
                utcSlots.add(new TimeSlot(startUTC.toLocalDateTime().toString(), endUTC.toLocalDateTime().toString()));
            }
        }

        // Find overlapping time slot
        Optional<TimeSlot> bestSlot = findOverlap(utcSlots);
        if (bestSlot.isEmpty()) {
            return Map.of("message", "No common time slot available");
        }
        // Convert back to user time zones
        Map<String, String> results = new HashMap<>();
        TimeSlot best = bestSlot.get();
        for (UserAvailability availability : availabilities) {
            ZoneId userZone = ZoneId.of(availability.getTimeZone());
            ZonedDateTime startLocal = ZonedDateTime.of(LocalDateTime.parse(best.getStartTime()), ZoneOffset.UTC).withZoneSameInstant(userZone);
            ZonedDateTime endLocal = ZonedDateTime.of(LocalDateTime.parse(best.getEndTime()), ZoneOffset.UTC).withZoneSameInstant(userZone);
            results.put(availability.getUserName(), startLocal.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME) + " to " + endLocal.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        }
        return results;
    }

    private Optional<TimeSlot> findOverlap(List<TimeSlot> slots) {
        // Sort slots by start time
        slots.sort(Comparator.comparing(TimeSlot::getStartTime));

        // Find overlapping time slot (basic algorithm)
        LocalDateTime latestStart = LocalDateTime.MIN;
        LocalDateTime earliestEnd = LocalDateTime.MAX;
        for (TimeSlot slot : slots) {
            LocalDateTime start = LocalDateTime.parse(slot.getStartTime());
            LocalDateTime end = LocalDateTime.parse(slot.getEndTime());
            latestStart = latestStart.isAfter(start) ? latestStart : start;
            earliestEnd = earliestEnd.isBefore(end) ? earliestEnd : end;
        }

        return latestStart.isBefore(earliestEnd) ? Optional.of(new TimeSlot(latestStart.toString(), earliestEnd.toString())) : Optional.empty();
    }
}

class UserAvailability {
    private String userName;
    private String timeZone;
    private List<TimeSlot> availableSlots;

    // Getters and Setters
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getTimeZone() { return timeZone; }
    public void setTimeZone(String timeZone) { this.timeZone = timeZone; }
    public List<TimeSlot> getAvailableSlots() { return availableSlots; }
    public void setAvailableSlots(List<TimeSlot> availableSlots) { this.availableSlots = availableSlots; }
}

class TimeSlot {
    private String startTime;
    private String endTime;

    public TimeSlot(String startTime, String endTime) {
        this.startTime = startTime;
        this.endTime = endTime;
    }
    public String getStartTime() { return startTime; }
    public String getEndTime() { return endTime; }
}