package com.example.rma.domain.bidRule;

import java.time.LocalDate;

public enum DealObjectAttrType {
    DATE("дата"),
    CALENDAR("дата из календаря"),
    COMMENT("комментарий"),
    TIME_END("время окончания")
    ;

    private final String name;



    DealObjectAttrType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
