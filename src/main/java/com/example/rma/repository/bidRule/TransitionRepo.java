package com.example.rma.repository.bidRule;


import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import com.example.rma.domain.bidRule.Transition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TransitionRepo extends JpaRepository<Transition, Long> {

    Transition findByBidRuleAndActionName(BidRule bidRule, String actionName);

    List<Transition> findByBidRule(BidRule bidRule);

    List<Transition> findBySourceState(State sourceState);

    @Query("select t from Transition t where t.sourceState.id = :sourceStateId")
    List<Transition> findBySourceStateId(@Param("sourceStateId") Long sourceStateId);

}
