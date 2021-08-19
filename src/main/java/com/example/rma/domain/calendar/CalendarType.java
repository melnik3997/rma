package com.example.rma.domain.calendar;

public enum  CalendarType {
    WORK("рабочий"),
    GENERAL("основной");

    private final String name;

    CalendarType(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
