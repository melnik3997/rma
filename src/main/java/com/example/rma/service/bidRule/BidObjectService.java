package com.example.rma.service.bidRule;

import com.example.rma.domain.WorkSchedule;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.bidRule.*;
import com.example.rma.repository.bidRule.DealObjectAttrRepo;
import com.example.rma.repository.bidRule.DealObjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BidObjectService {

    @Autowired
    private DealObjectRepo dealObjectRepo;

    @Autowired
    private DealObjectAttrRepo dealObjectAttrRepo;

    @Autowired
    private TransitionService transitionService;

    @Transactional
    public Map<String, String> createBidObject(DealObject dealObject, List<DealObjectAttr> dealObjectAttrList){
        Map<String, String> errors = new HashMap<>();

        //по умолчанию ставим ответсвенного автора
        dealObject.setResponsible(dealObject.getAuthor());
        DealObject dealObjectDB = saveDealObject(dealObject);

        dealObjectAttrList.forEach(a-> a.setDealObject(dealObjectDB));
        List<DealObjectAttr> dealObjectAttrListDB = saveAllDealObjectAttr(dealObjectAttrList);

        //выполняем действие создания формируем протокол
        Transition transition = transitionService.getFirstTransitionByDealObject(dealObject);

        Protocol protocol = transitionService.doTransition(dealObjectDB, transition);

        return errors;
    }

    public DealObject saveDealObject(DealObject dealObject){
        return dealObjectRepo.save(dealObject);
    }

    private List<DealObjectAttr> saveAllDealObjectAttr(List<DealObjectAttr> dealObjectAttrList){
        return dealObjectAttrRepo.saveAll(dealObjectAttrList);
    }
}
