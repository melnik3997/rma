package com.example.rma;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.BidType;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.bidRule.BidRuleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
//@AutoConfigureTestDatabase
@TestPropertySource("/application-test.properties")
public class StateTest {

    @Autowired
    private BidRuleService bidRuleService;

    @Autowired
    private EnterpriseService enterpriseService;



    @Test
    public void test() throws Exception{
        Enterprise enterprise = enterpriseService.findById(80L);
        BidRule bidRule = new BidRule("Отпуск", BidType.VACATION,enterprise );

        bidRuleService.create(bidRule);

        BidRule bidRuleDB = bidRuleService.findAll().get(0);







    }
}
