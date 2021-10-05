package com.example.rma.repository.bidRule;


import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import com.example.rma.domain.bidRule.Transition;
import com.example.rma.domain.bidRule.dto.DealObjectDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TransitionRepo extends JpaRepository<Transition, Long> {

    Transition findByBidRuleAndActionName(BidRule bidRule, String actionName);

    List<Transition> findByBidRule(BidRule bidRule);

    List<Transition> findBySourceState(State sourceState);

    List<Transition> findByTargetState(State targetState);

    @Query("select t from Transition t where t.sourceState.id = :sourceStateId")
    List<Transition> findBySourceStateId(@Param("sourceStateId") Long sourceStateId);

    @Query("select t1 from DealObject d " +
            " inner join Protocol p" +
            " on p.id = d.protocol " +
            " inner join Transition t " +
            " on t.id = p.transition " +
            " inner join Transition t1 " +
            " on t1.sourceState = t.targetState" +
            " where d.id = :dealObject")
    List<Transition> findAvailableTransitionByDealObjectId(@Param("dealObject") Long dealObject);

}
