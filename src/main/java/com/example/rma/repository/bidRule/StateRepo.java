package com.example.rma.repository.bidRule;

import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import com.example.rma.domain.bidRule.StateType;
import com.example.rma.domain.dto.StateDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface StateRepo extends JpaRepository<State, Long> {

    List<State> findByBidRule(BidRule bidRule);

    State findByBidRuleAndBrief(BidRule bidRule, String brief);

    List<State> findByBidRuleAndStateType(BidRule bidRule, StateType stateType);

    @Query("select new com.example.rma.domain.dto.StateDto( s )" +
            " from State s " +
            "where bidRule = :bidRule")
    List<StateDto> findStateDtoByBidRule(@Param("bidRule") BidRule bidRule);
}
