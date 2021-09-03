package com.example.rma.domain.bidRule;

public enum BidType {
    VACATION("отпуск"),
    TIME_OFF("отгул");


    private final String name;


    BidType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
