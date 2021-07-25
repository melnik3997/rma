package com.example.rma.domain;

public enum PostLevel {
    specialist(""),
    middle("старший"),
    leading("ведущий"),
    senior("главный");

    private final String name;

    PostLevel(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
