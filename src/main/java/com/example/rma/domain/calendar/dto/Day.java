package com.example.rma.domain.calendar.dto;

import com.example.rma.domain.calendar.DayType;
import com.example.rma.domain.calendar.DayWeek;
import com.fasterxml.jackson.annotation.JsonProperty;


public class Day {
    @JsonProperty("id")
    private Long id;
    @JsonProperty("day")
    private Integer day;
    @JsonProperty("dayWeek")
    private DayWeek dayWeek;
    @JsonProperty("dayType")
    private DayType dayType;

    public Day(Long id, Integer day, DayWeek dayWeek, DayType dayType) {
        this.id = id;
        this.day = day;
        this.dayWeek = dayWeek;
        this.dayType = dayType;
    }

    public Day(){

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getDay() {
        return day;
    }

    public void setDay(Integer day) {
        this.day = day;
    }

    public DayWeek getDayWeek() {
        return dayWeek;
    }

    public void setDayWeek(DayWeek dayWeek) {
        this.dayWeek = dayWeek;
    }

    public DayType getDayType() {
        return dayType;
    }

    public void setDayType(DayType dayType) {
        this.dayType = dayType;
    }

    @Override
    public String toString() {
        return "Day{" +
                "id=" + id +
                ", day=" + day +
                ", dayWeek=" + dayWeek +
                ", dayType=" + dayType +
                '}';
    }
}
