package com.example.rma.domain.bidRule;

public enum  StateType {

    INTRODUCED("введен"),
    PROCESSED("обрабатывается"),
    VERIFIED("верифицируется"),
    CLOSED("закрыт");

    private final String name;

    StateType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
