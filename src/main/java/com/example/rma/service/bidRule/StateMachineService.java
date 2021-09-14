package com.example.rma.service.bidRule;

import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.dto.StateDto;
import com.example.rma.repository.bidRule.StateRepo;
import com.example.rma.repository.bidRule.TransitionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StateMachineService {

    @Autowired
    public StateRepo stateRepo;

    @Autowired
    public TransitionRepo transitionRepo;

    public List<State> findStateByBidRule(BidRule bidRule){
        return stateRepo.findByBidRule(bidRule);
    }

    private int getMaxNumber(BidRule bidRule){
        List<State> stateList = findStateByBidRule(bidRule);

        if (stateList != null && !stateList.isEmpty()){
            return stateList.stream().max(State::compare).get().getNumber();
        }
        return -1;
    }

    public State findStateByBidRuleAndBrief(BidRule bidRule, String brief){
        return stateRepo.findByBidRuleAndBrief(bidRule, brief);
    }

    public List<State> findStateByBidRuleAndStateType(BidRule bidRule, StateType stateType){
        return stateRepo.findByBidRuleAndStateType(bidRule, stateType);
    }

    public boolean checkStateBrief(BidRule bidRule, String brief) {
        return !(findStateByBidRuleAndBrief(bidRule, brief) == null);
    }

    @Transactional
    public Map<String, String> createState(State state){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(checkStateBrief(state.getBidRule(), state.getBrief())){
            errors.put("briefError", "У заявки уже есть состояние с таким сокращением");
            error = true;
        }
        state.setNumber(getMaxNumber(state.getBidRule())+1);

        if(!error){
            saveState(state);
            //создаем системный переход по созданию объекта для обеспечения протоколирования
            if(state.getStateType() == StateType.INTRODUCED){
                Transition transition = new Transition(null, state.getBidRule(), null, ActionType.CREATE.getName(), ActionType.CREATE, state, null);
                createTransition(transition);
            }
        }
        return errors;
    }

    private State saveState(State state){
        return stateRepo.save(state);
    }

    private Transition saveTransition(Transition transition){
        return transitionRepo.save(transition);
    }

    public Transition findTransitionByBidRuleAndActionName(BidRule bidRule, String actionName){

        return transitionRepo.findByBidRuleAndActionName(bidRule, actionName);
    }

    public boolean checkTransitionActionName(BidRule bidRule, String actionName) {
        return !(findTransitionByBidRuleAndActionName(bidRule, actionName) == null);
    }


    public Map<String, String> createTransition(Transition transition){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(checkTransitionActionName(transition.getBidRule(), transition.getActionName())){
            errors.put("briefError", "У заявки уже есть действие с таким наименованием");
            error = true;
        }
        if(!error){
            saveTransition(transition);
        }

        return errors;
    }

    public List<StateDto> findStateDtoByBidRule(BidRule bidRule){
        List<StateDto> stateDtoList = stateRepo.findStateDtoByBidRule(bidRule);

        for (StateDto stateDto: stateDtoList) {
            stateDto.setTransitionList(transitionRepo.findBySourceStateId(stateDto.getId()));

        }
        return stateDtoList;
    }

    public List<Transition> findTransitionBySourceState(State state){
        return transitionRepo.findBySourceState(state);
    }

    public List<Transition> findTransitionByTargetState(State state){
        return transitionRepo.findByTargetState(state);
    }

    public Map<String, String> deleteState(State state){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(state == null){
            error = true;
        }else if(!findTransitionBySourceState(state).isEmpty()){
            error = true;
            errors.put("error", "У состояния есть связанное действие");
        }else if(!findTransitionByTargetState(state).isEmpty()){
            error = true;
            errors.put("error", "У состояния есть связанное действие");
        }

        if(!error){
            stateRepo.delete(state);
        }


        return errors;

    }
}
