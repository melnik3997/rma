package com.example.rma.domain.bidRule;

import com.example.rma.exception.BusinessException;
import com.example.rma.service.bid.LeaveEarlyService;
import com.example.rma.service.bid.TimeOffService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.bidRule.ProtocolService;
import com.example.rma.service.bidRule.StateMachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.EnumSet;

public enum ActionType {

    VERIFY("верифицировать"){
        @Override
        public DealObject beforeDoTransition(DealObject dealObject, Transition transition) throws BusinessException {
            switch (dealObject.getBidRule().getBidType()){
                case TIME_OFF:
                    dealObject = timeOffService.beforeDoTransitionVERIFY(dealObject, transition);
                    break;
            }
            return dealObject;
        }
    },
    CREATE("создать"){
        @Override
        public void rollbackAction(DealObject dealObject, Protocol protocol)throws BusinessException {
            bidObjectService.delete(dealObject);
            protocolService.delete(protocol);
        }
    },
    PROCESS("обработать"){
        @Override
        public DealObject beforeDoTransition(DealObject dealObject, Transition transition) throws BusinessException {

            switch (dealObject.getBidRule().getBidType()){
                case LEAVE_EARLY:
                    dealObject = leaveEarlyService.beforeDoTransitionProcess(dealObject,transition);
                    break;
                case TIME_OFF:
                    dealObject = timeOffService.beforeDoTransitionPROCESS(dealObject, transition);
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
                    dealObject = leaveEarlyService.beforeDoTransitionClose(dealObject,transition);
                    break;
            }


            return dealObject;
        }
    };

    private final String name;

    public LeaveEarlyService leaveEarlyService;

    public BidObjectService bidObjectService;

    public ProtocolService protocolService;

    public TimeOffService timeOffService;

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

    public void rollbackAction(DealObject dealObject, Protocol protocol) throws BusinessException{

    }

    public void setLeaveEarlyService(LeaveEarlyService leaveEarlyService) {
        this.leaveEarlyService = leaveEarlyService;
    }

    public void setBidObjectService(BidObjectService bidObjectService) {
        this.bidObjectService = bidObjectService;
    }

    public void setProtocolService(ProtocolService protocolService) {
        this.protocolService = protocolService;
    }

    public void setTimeOffService(TimeOffService timeOffService) {
        this.timeOffService = timeOffService;
    }

    @Component
    public static class ReportTypeServiceInjector {
        @Autowired
        private LeaveEarlyService leaveEarlyService;

        @Autowired
        private BidObjectService bidObjectService;

        @Autowired
        private ProtocolService protocolService;

        @Autowired
        private TimeOffService timeOffService;

        @PostConstruct
        public void postConstruct() {
            for (ActionType rt : EnumSet.allOf(ActionType.class)) {
                rt.setLeaveEarlyService(leaveEarlyService);
                rt.setBidObjectService(bidObjectService);
                rt.setProtocolService(protocolService);
                rt.setTimeOffService(timeOffService);
            }
        }
    }
}
