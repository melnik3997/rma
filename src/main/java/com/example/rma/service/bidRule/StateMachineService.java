package com.example.rma.service.bidRule;

import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import com.example.rma.repository.bidRule.StateRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StateMachineService {

    @Autowired
    public StateRepo stateRepo;

    public List<State> findByBidRule(BidRule bidRule){
        return stateRepo.findByBidRule(bidRule);
    }

    private int getMaxNumber(BidRule bidRule){
        List<State> stateList = findByBidRule(bidRule);

        if (stateList != null && !stateList.isEmpty()){
            return stateList.stream().max(State::compare).get().getNumber();
        }
        return -1;
    }

    public State findByBidRuleAndBrief(BidRule bidRule, String brief){
        return stateRepo.findByBidRuleAndBrief(bidRule, brief);
    }

    public boolean checkStateBrief(BidRule bidRule, String brief) {
        return !(findByBidRuleAndBrief(bidRule, brief) == null);
    }

    public Map<String, String> create(State state){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(checkStateBrief(state.getBidRule(), state.getBrief())){
            errors.put("briefError", "У заявки уже есть состояние с таким сокращением");
            error = true;
        }
        state.setNumber(getMaxNumber(state.getBidRule())+1);

        if(!error){
            save(state);
        }
        return errors;
    }

    private State save(State state){
        return stateRepo.save(state);
    }
}
