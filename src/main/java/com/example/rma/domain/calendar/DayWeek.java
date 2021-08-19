package com.example.rma.domain.calendar;

public enum DayWeek {

    MONDAY("понедельник"),
    TUESDAY("вторник"),
    WEDNESDAY("среда"),
    THURSDAY("четверг"),
    FRIDAY("пятница"),
    SATURDAY("суббота"),
    SUNDAY("воскресенье");

    private final String name;

    DayWeek(String name){
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
