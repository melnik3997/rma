package com.example.rma.domain.calendar.dto;

import java.util.List;

public class Week {

    private Integer numberWeek;

    private List<Day> dayList;

    public Week(Integer numberWeek) {
        this.numberWeek = numberWeek;
    }

    public Integer getNumberWeek() {
        return numberWeek;
    }

    public void setNumberWeek(Integer numberWeek) {
        this.numberWeek = numberWeek;
    }

    public List<Day> getDayList() {
        return dayList;
    }

    public void setDayList(List<Day> dayList) {
        this.dayList = dayList;
    }

    @Override
    public String toString() {
        return "Week{" +
                "numberWeek=" + numberWeek +
                ", dayList=" + dayList +
                '}';
    }
}
