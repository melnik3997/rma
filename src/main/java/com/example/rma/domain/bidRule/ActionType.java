package com.example.rma.domain.bidRule;

import com.example.rma.exception.BusinessException;
import com.example.rma.service.bid.LeaveEarlyService;
import com.example.rma.service.bidRule.StateMachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.EnumSet;

public enum ActionType {

    VERIFY("верифицировать"),
    CREATE("создать"),
    PROCESS("обработать"){
        @Override
        public DealObject beforeDoTransition(DealObject dealObject, Transition transition) {

            switch (dealObject.getBidRule().getBidType()){
                case LEAVE_EARLY:
                    leaveEarlyService.beforeDoTransitionProcess(dealObject,transition);
                    break;
            }
            return dealObject;
        }
    },
    CLOSED("закрыть"){
        @Override
        public DealObject beforeDoTransition(DealObject dealObject, Transition transition) throws BusinessException {

            switch (dealObject.getBidRule().getBidType()){
                case LEAVE_EARLY:
                    leaveEarlyService.beforeDoTransitionClose(dealObject,transition);
                    break;
            }


            return dealObject;
        }
    };

    private final String name;

    public LeaveEarlyService leaveEarlyService;

    ActionType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public DealObject beforeDoTransition(DealObject dealObject, Transition transition) throws BusinessException {
        return dealObject;
    }

    public DealObject afterDoTransition(DealObject dealObject, Transition transition, Protocol protocol) throws BusinessException {
        return dealObject;
    }

    public void setLeaveEarlyService(LeaveEarlyService leaveEarlyService) {
        this.leaveEarlyService = leaveEarlyService;
    }

    @Component
    public static class ReportTypeServiceInjector {
        @Autowired
        private LeaveEarlyService leaveEarlyService;

        @PostConstruct
        public void postConstruct() {
            for (ActionType rt : EnumSet.allOf(ActionType.class))
                rt.setLeaveEarlyService(leaveEarlyService);
        }
    }
}
