package com.example.rma.service.bidRule;

import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class TransitionService {

    @Autowired
    private StateMachineService stateMachineService;

    @Autowired
    private UserService userService;

    @Autowired
    private ProtocolService protocolService;

    @Autowired
    private BidObjectService bidObjectService;

    public Transition getFirstTransitionByDealObject(DealObject dealObject){
        Transition transition = null;

        BidRule bidRule = dealObject.getBidRule();
        State state = stateMachineService.findStateByBidRuleAndStateType(bidRule, StateType.INTRODUCED).get(0);
        if(state == null){
            return null;
        }
        transition = stateMachineService.findTransitionByTargetState(state).get(0);

        return transition;

    }

    public Protocol doTransition(DealObject dealObject, Transition transition){
        //вызываем пред обработку

        //формируем протокол

        LocalDate dateProtocol = LocalDate.now();

        User user ;
        if(transition.getInstitution() == null) {
            user = dealObject.getResponsible().getUser();
        }else {
            user = transition.getInstitution().getUser();
        }
        Protocol protocol = new Protocol(dealObject, dateProtocol, transition,user );

        Protocol protocolDB = protocolService.save(protocol);
        dealObject.setProtocol(protocolDB);
        bidObjectService.saveDealObject(dealObject);

        //вызываем пост обработку


        return protocolDB;
    }
}
