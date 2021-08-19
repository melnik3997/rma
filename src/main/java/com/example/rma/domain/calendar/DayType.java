package com.example.rma.domain.calendar;

public enum DayType {
    WORK("рабочий"),
    OUTPUT("выходной"),
    HOLIDAY("праздничный"),
    PRE_HOLIDAY("предпраздничный");

    private final String name;

    DayType(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
