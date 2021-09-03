package com.example.rma.service.bidRule;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.repository.bidRule.BidRuleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BidRuleService {

    @Autowired
    private BidRuleRepo bidRuleRepo;

    public Map<String, String> create(BidRule bidRule){
        Map<String, String> errors = new HashMap<>();

        bidRule.setActive(false);

        save(bidRule);

        return errors;
    }

    public List<BidRule> findAll(){
        return bidRuleRepo.findAll();
    }

    private void save(BidRule bidRule){
        bidRuleRepo.save(bidRule);
    }

    public List<BidRule> findByEnterprise(Enterprise enterprise){

        return bidRuleRepo.findByEnterprise(enterprise);
    }

    public List<BidRule> findByEnterpriseAndActive(Enterprise enterprise, boolean active){

        return bidRuleRepo.findByEnterpriseAndActive(enterprise, active);
    }
}
