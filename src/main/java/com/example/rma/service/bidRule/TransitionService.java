package com.example.rma.service.bidRule;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.bidRule.TransitionRepo;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.ArrayList;
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

    @Autowired
    private TransitionRepo transitionRepo;

    /**
     * Получение первого перехода при создании объекта
     * @param dealObject
     * @return
     */
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

    /**
     * Доступные действия по состоянию
     * @param dealObjectId
     * @return
     */
    public List<Transition> getAvailableTransitionByDealObject(Long dealObjectId){
        List<Transition> transitionList = transitionRepo.findAvailableTransitionByDealObjectId(dealObjectId);
        return transitionList;
    }

    /**
     * Выполнение дейсвия по объекту
     * @param dealObject
     * @param transition
     * @return
     */
    @Transactional
    public Protocol doTransition(DealObject dealObject, Transition transition) throws BusinessException {

        //находим действие
        ActionType action = transition.getActionType();
        //вызываем пред обработку
        dealObject = action.beforeDoTransition(dealObject, transition);
        //формируем протокол
        LocalDateTime dateProtocol = LocalDateTime.now();
        //находим текущего пользователя
        User user = userService.getCurrentUser();
        Institution responsible;
        //установка ответсвенного за переход
        if(transition.getInstitution() == null) {
            if(dealObject.getResponsible() == null ){
                responsible = null;
            }else {
                responsible = dealObject.getResponsible();
            }
        }else {
            responsible = transition.getInstitution();
            if(!responsible.getId().equals(dealObject.getResponsible().getId())){
                dealObject.setResponsible(transition.getInstitution());
                dealObject = bidObjectService.saveDealObject(dealObject);
            }
        }
        //создаем протокол по выполненному дейсию
        Protocol protocol = new Protocol(dealObject, dateProtocol, transition,user,responsible );
        protocol = protocolService.save(protocol);
        //устанавливаем последний протокол
        dealObject.setProtocol(protocol);
        //сохраняем объект
        dealObject = bidObjectService.saveDealObject(dealObject);
        //вызываем пост обработку
        action.afterDoTransition(dealObject, transition, protocol);

        return protocol;
    }
}
