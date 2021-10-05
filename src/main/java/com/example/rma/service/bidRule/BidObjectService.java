package com.example.rma.service.bidRule;

import com.example.rma.domain.Institution;
import com.example.rma.domain.WorkSchedule;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.bidRule.dto.DealObjectDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.bidRule.DealObjectAttrRepo;
import com.example.rma.repository.bidRule.DealObjectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class BidObjectService {

    @Autowired
    private DealObjectRepo dealObjectRepo;

    @Autowired
    private DealObjectAttrRepo dealObjectAttrRepo;

    @Autowired
    private TransitionService transitionService;

    @Autowired
    private ProtocolService protocolService;

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

        try {
            Protocol protocol = transitionService.doTransition(dealObjectDB, transition);
        } catch (BusinessException e) {
            errors.put("createError", e.getMessage());
        }
        return errors;
    }

    public DealObject saveDealObject(DealObject dealObject){
        return dealObjectRepo.save(dealObject);
    }

    private List<DealObjectAttr> saveAllDealObjectAttr(List<DealObjectAttr> dealObjectAttrList){
        return dealObjectAttrRepo.saveAll(dealObjectAttrList);
    }

    public List<DealObject> findDealObjectByResponsible(Institution responsible){
        return dealObjectRepo.findByResponsible(responsible);
    }

    public List<DealObjectDto> findDealObjectByParam(Institution responsible,  Institution author, State state, Institution employee){
        List<DealObjectDto> dealObjectDtoList = dealObjectRepo.findDealObjectDtoByParam(responsible, author, state, employee);

        dealObjectDtoList.forEach(d-> {
            d.setAvailableTransitionList(transitionService.getAvailableTransitionByDealObject(d.getId()));
            d.setProtocolList(protocolService.findByDealObjectId(d.getId()));
        });

        return dealObjectDtoList;
    }


    public String getValueDealObjectAttrByType(List<DealObjectAttr> dealObjectAttrList, DealObjectAttrType dealObjectAttrType){
        List<DealObjectAttr> find= getDealObjectAttrByType(dealObjectAttrList, dealObjectAttrType);
        if(find == null || find.isEmpty()){
            return null;
        }
        DealObjectAttr dealObjectAttr = getDealObjectAttrByType(dealObjectAttrList, dealObjectAttrType).get(0);

        return dealObjectAttr.getValueAttr();
    }

    public List<DealObjectAttr> getDealObjectAttrByType(List<DealObjectAttr> dealObjectAttrList, DealObjectAttrType dealObjectAttrType){
        return dealObjectAttrList.stream().filter(dealObjectAttr -> dealObjectAttr.getDealObjectAttrType()== dealObjectAttrType).collect(Collectors.toList());
    }

    public List<DealObjectAttr> findDealObjectAttrByDealObject(DealObject dealObject){
        return dealObjectAttrRepo.findByDealObject(dealObject);
    }
}
