package com.example.rma.service.bid;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.WorkScheduleCorrectType;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleCorrectService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TimeOffService {
    @Autowired
    private UserService userService;

    @Autowired
    private UtilBidService utilBidService;

    @Autowired
    private BidObjectService bidObjectService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private WorkScheduleCorrectService workScheduleCorrectService;

    public Map<String, String> create(BidRule bidRule, User author, String date, String comment){
        Map<String, String> errors = new HashMap<>();

        if(bidRule.getBidType() != BidType.TIME_OFF){
            errors.put("errorCreate", "Правило заявки не корректного типа");
            return errors;
        }
        Boolean error = false;
        List<DealObjectAttr> dealObjectAttrList =new ArrayList<>();

        Institution institution = userService.findInstitutionByUser(author);

        Calendar calendar = utilBidService.getCalendarAndCheck(date, institution, errors);

        if (errors.size() > 0) {
            return errors;
        }
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.CALENDAR, calendar.getId().toString()));
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.COMMENT, comment));

        DealObject dealObject = new DealObject(bidRule, institution, institution);

        bidObjectService.createBidObject(dealObject, dealObjectAttrList);

        return errors;
    }

    public DealObject beforeDoTransitionVERIFY(DealObject dealObject, Transition transition){
        return utilBidService.setEmployeeByDealObject(dealObject, transition);
    }

    public DealObject beforeDoTransitionPROCESS(DealObject dealObject, Transition transition) throws BusinessException {
        List<DealObjectAttr> dealObjectAttrList = bidObjectService.findDealObjectAttrByDealObject(dealObject);

        WorkScheduleCorrect workScheduleCorrect = new WorkScheduleCorrect(dealObject.getEmployee(), dealObject, WorkScheduleCorrectType.TIME_OFF);
        Calendar calendar = calendarService.findCalendarById(Long.parseLong(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.CALENDAR)));
        workScheduleCorrect.setCalendar(calendar);
        workScheduleCorrect.setComment(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.COMMENT));

        workScheduleCorrect = workScheduleCorrectService.create(workScheduleCorrect);

        dealObject.setResponsible(null);
        dealObject = bidObjectService.saveDealObject(dealObject);
        return dealObject;
    }

}
