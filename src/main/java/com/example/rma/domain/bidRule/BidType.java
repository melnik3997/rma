package com.example.rma.domain.bidRule;

import com.example.rma.domain.WorkScheduleCorrect;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public enum BidType {
    VACATION("отпуск"){
        @Override
        public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList) {
            return super.create(bidRule, workScheduleCorrectList, dealObjectAttrList);
        }
    },



    TIME_OFF("отгул"){
        @Override
        public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList) {
            return super.create(bidRule, workScheduleCorrectList, dealObjectAttrList);
        }
    };


    private final String name;

    public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList){

        return new HashMap<>();
    }


    BidType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
