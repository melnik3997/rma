package com.example.rma.domain;

public enum WorkScheduleCorrectType {

    LEAVE_EARLY("уйти раньше"),
    TIME_OFF("отгул"),
    VACATION("отпуск");

    private final String name;

    WorkScheduleCorrectType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
