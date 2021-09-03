package com.example.rma.repository.bidRule;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.bidRule.BidRule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BidRuleRepo extends JpaRepository<BidRule, Long> {

    List<BidRule> findByEnterprise(Enterprise enterprise);

    List<BidRule> findByEnterpriseAndActive(Enterprise enterprise, boolean active);
}
