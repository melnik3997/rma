package com.example.rma.domain.bidRule;

import java.time.LocalDate;

public enum DealObjectAttrType {
    DATE("дата"),
    CALENDAR("дата из календаря"){
        @Override
        public Long getValue(DealObjectAttr dealObjectAttr) {
            return Long.parseLong(dealObjectAttr.getValueAttr());
        }
    },
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

    public Object getValue(DealObjectAttr dealObjectAttr){
        return dealObjectAttr.getValueAttr();
    }
}
