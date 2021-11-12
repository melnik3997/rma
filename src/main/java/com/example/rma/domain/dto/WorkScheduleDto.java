package com.example.rma.domain.dto;

import com.example.rma.domain.WorkSchedule;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.DayType;

import javax.persistence.Column;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class WorkScheduleDto {

    private Calendar calendar;

    private LocalDate date;

    private LocalTime timeBegin;

    private LocalTime timeFinish;

    private Double workTime;

    private Double lunchBreak;

    private DayType dayType;

    private int day;

    private int month;

    private Double obligatoryWorkTime;

    private boolean isPresence;


    public WorkScheduleDto(Calendar calendar, WorkSchedule workSchedule) {
        this.calendar = calendar;
        this.date = calendar.getDateD();
        this.timeBegin = workSchedule.getTimeBegin();
        this.timeFinish = workSchedule.getTimeFinish();
        this.workTime = workSchedule.getWorkTime();
        this.lunchBreak = workSchedule.getLunchBreak();
        this.dayType = calendar.getDayType();
        this.day = calendar.getDateInt();
        this.month = calendar.getMonthInt();
    }

    public Calendar getCalendar() {
        return calendar;
    }

    public void setCalendar(Calendar calendar) {
        this.calendar = calendar;
    }

    public LocalDate getDate() {
        return date;
    }

    public String getDateString() {
        if(date != null)
            return date.format(DateTimeFormatter.ofPattern("dd.MM.yyyy"));

        return "";
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getTimeBegin() {
        return timeBegin;
    }

    public void setTimeBegin(LocalTime timeBegin) {
        this.timeBegin = timeBegin;
    }

    public LocalTime getTimeFinish() {
        return timeFinish;
    }

    public void setTimeFinish(LocalTime timeFinish) {
        this.timeFinish = timeFinish;
    }

    public Double getWorkTime() {
        return workTime;
    }

    public void setWorkTime(Double workTime) {
        this.workTime = workTime;
    }

    public Double getLunchBreak() {
        return lunchBreak;
    }

    public void setLunchBreak(Double lunchBreak) {
        this.lunchBreak = lunchBreak;
    }

    public DayType getDayType() {
        return dayType;
    }

    public void setDayType(DayType dayType) {
        this.dayType = dayType;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public Double getObligatoryWorkTime() {
        return obligatoryWorkTime;
    }

    public boolean isPresence() {
        return isPresence;
    }

    public void setPresence(boolean presence) {
        isPresence = presence;
    }

    public void setObligatoryWorkTime(Double obligatoryWorkTime) {
        this.obligatoryWorkTime = obligatoryWorkTime;
    }
}
