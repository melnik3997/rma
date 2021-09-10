package com.example.rma.service.bidRule;

import com.example.rma.domain.WorkSchedule;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.BidType;
import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.bidRule.DealObjectAttr;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BidObjectService {

    public Map<String, String> createBidObject(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList){
        Map<String, String> errors = new HashMap<>();

        BidType bidType = bidRule.getBidType();

        errors.putAll(bidType.create(bidRule, workScheduleCorrectList, dealObjectAttrList));

        return errors;
    }
}
