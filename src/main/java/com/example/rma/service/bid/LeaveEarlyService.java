package com.example.rma.service.bid;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.WorkScheduleCorrectType;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleCorrectService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LeaveEarlyService {

    @Autowired
    private UserService userService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private BidObjectService bidObjectService;

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private WorkScheduleCorrectService workScheduleCorrectService;

    public Map<String, String> create(BidRule bidRule, User author, String date, String timeLeave, String comment){
        Map<String, String> errors = new HashMap<>();

        if(bidRule.getBidType() != BidType.LEAVE_EARLY){
            errors.put("errorCreate", "Правило заявки не корректного типа");
            return errors;
        }
        boolean error = false;
        List<DealObjectAttr> dealObjectAttrList =new ArrayList<>();

        Institution institution = userService.findInstitutionByUser(author);
        LocalDate dateD = null;
        try {
            dateD = LocalDate.parse(date, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        }catch (Exception e){
            error = true;
            errors.put("dateError", "Не корректно указана дата");
        }
        if(error){
            return errors;
        }
        Calendar calendar = calendarService.findCalendarByDateAndInstitution(institution, dateD);

        if(calendar == null){
            errors.put("dateError", "Не определена дата в активном календаре");
            error = true;
        }else if(LocalDate.now().compareTo(dateD) > 0){
            error = true;
            errors.put("dateError", "Дата заявки не может быть меньше текущей даты");
        }
        if(checkTime(timeLeave)){
            error = true;
            errors.put("timeLeaveError", "Не корректное время");
        }
        if (error) {
            return errors;
        }

        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.CALENDAR, calendar.getId().toString()));
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.COMMENT, comment));
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.TIME_END, timeLeave));

        DealObject dealObject = new DealObject(bidRule, institution, institution);

        bidObjectService.createBidObject(dealObject, dealObjectAttrList);


        return errors;
    }

    public DealObject beforeDoTransitionProcess(DealObject dealObject, Transition transition ){

        Institution institution = dealObject.getEmployee();
        Institution leader =  institutionService.findInstitutionByInstitutionDto(institutionService.findLeaderByInstitution(institution));

        //если нашли руководителя ставим его ответсвенным
        if(leader != null){
            dealObject.setResponsible(leader);
        }else{
            dealObject.setResponsible(institution);
        }
        dealObject = bidObjectService.saveDealObject(dealObject);
        return dealObject;
    }

    public DealObject beforeDoTransitionClose(DealObject dealObject, Transition transition ) throws BusinessException {

        List<DealObjectAttr> dealObjectAttrList = bidObjectService.findDealObjectAttrByDealObject(dealObject);

        WorkScheduleCorrect workScheduleCorrect = new WorkScheduleCorrect(dealObject.getEmployee(), dealObject, WorkScheduleCorrectType.LEAVE_EARLY);

        Calendar calendar = calendarService.findCalendarById(Long.parseLong(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.CALENDAR)));
        LocalTime time = LocalTime.parse(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.TIME_END));

        workScheduleCorrect.setCalendar(calendar);
        workScheduleCorrect.setTimeFinish(time);
        workScheduleCorrect.setComment(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.COMMENT));


        workScheduleCorrect = workScheduleCorrectService.create(workScheduleCorrect);

        dealObject.setResponsible(null);
        dealObject = bidObjectService.saveDealObject(dealObject);
        return dealObject;
    }



    private boolean checkTime(String time) {
        return time.equals("__:__");
    }

}
