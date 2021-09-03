package com.example.rma.repository.bidRule;

import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StateRepo extends JpaRepository<State, Long> {

    List<State> findByBidRule(BidRule bidRule);

    State findByBidRuleAndBrief(BidRule bidRule, String brief);
}
