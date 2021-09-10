package com.example.rma.domain.bidRule;

import java.time.LocalDate;

public enum DealObjectAttrType {
    DATE("дата")
    ;

    private final String name;



    DealObjectAttrType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
