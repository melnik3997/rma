package com.example.rma.domain.calendar.dto;

import java.util.List;

public class Month {

    private Integer number;

    private String name;

    private List<Week> weekList;

    public Month(Integer number, String name, List<Week> weekList) {
        this.number = number;
        this.name = name;
        this.weekList = weekList;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Week> getWeekList() {
        return weekList;
    }

    public void setWeekList(List<Week> weekList) {
        this.weekList = weekList;
    }

    @Override
    public String toString() {
        return "Month{" +
                "number=" + number +
                ", name='" + name + '\'' +
                ", weekList=" + weekList +
                '}';
    }
}
