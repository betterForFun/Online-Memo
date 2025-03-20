package com.example.Online.Memo.entity;

import java.time.LocalDate;

public class timeSlot {
    private String startTime;
    private String endTime;
    private String timeZone; // For example, "America/New_York" or "Asia/Tokyo"

    private LocalDate date;

    public timeSlot(){

    }

    public timeSlot(String startTime, String endTime, String timezoneInput, LocalDate date) {
        this.startTime = startTime;
        this.endTime = endTime;
        this.timeZone = timezoneInput;
        this.date = date;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getTimeZone() {
        return timeZone;
    }

    public void setTimeZone(String timeZone) {
        this.timeZone = timeZone;
    }


    public String getStartTime() { return startTime; }
    public String getEndTime() { return endTime; }
    public String getTimezoneInput() { return timeZone; }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}