package com.example.rma.domain.bidRule;

import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.service.bidRule.StateMachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public enum BidType {
    VACATION("отпуск", "vacationForm", "vacation"){
        @Override
        public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList) {
            return super.create(bidRule, workScheduleCorrectList, dealObjectAttrList);
        }
    },



    TIME_OFF("отгул", "timeOffForm", "timeOff"){
        @Override
        public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList) {
            return super.create(bidRule, workScheduleCorrectList, dealObjectAttrList);
        }

    },
    LEAVE_EARLY("уйти раньше", "leaveEarlyForm","leaveEarly" ){
        @Override
        public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList) {
            return super.create(bidRule, workScheduleCorrectList, dealObjectAttrList);
        }

    };


    private final String name;

    private final String formName;

    private final String urlName;

    private StateMachineService stateMachineService;


    public Map<String, String> checkBidRuleByActive(BidRule bidRule){
        Map<String, String> errors = new HashMap<>();

        List<State> stateByBidRule = stateMachineService.findStateByBidRule(bidRule);

        State stateTmp = stateByBidRule.stream().filter(state -> state.getStateType().equals(StateType.INTRODUCED)).findFirst().orElse(null);

        if(stateTmp == null){
            errors.put("activeError", "Отсутствует состояние введен");
            return errors;
        }

        stateTmp = stateByBidRule.stream().filter(state -> state.getStateType().equals(StateType.CLOSED)).findFirst().orElse(null);
        if(stateTmp == null){
            errors.put("activeError", "Отсутствует состояние закрыт");
            return errors;
        }

        return errors;
    }

    public Map<String, String> create(BidRule bidRule, List<WorkScheduleCorrect> workScheduleCorrectList, List<DealObjectAttr> dealObjectAttrList){

        return new HashMap<>();
    }

    BidType(String name, String formName, String urlName) {
        this.name = name;
        this.formName = formName;
        this.urlName = urlName;
    }

    public String getName() {
        return name;
    }

    public String getFormName() {
        return formName;
    }

    public String getUrlName() {
        return urlName;
    }

    public void setStateMachineService(StateMachineService stateMachineService) {
        this.stateMachineService = stateMachineService;
    }

    @Component
    public static class ReportTypeServiceInjector {
        @Autowired
        private StateMachineService stateMachineService;

        @PostConstruct
        public void postConstruct() {
            for (BidType rt : EnumSet.allOf(BidType.class))
                rt.setStateMachineService(stateMachineService);
        }
    }
}
