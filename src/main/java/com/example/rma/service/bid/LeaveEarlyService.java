package com.example.rma.service.bid;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.service.UserService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
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
        Calendar calendar = calendarService.findCalendarByDateAndInstitution(institution, dateD);

        if(calendar == null){
            errors.put("dateError", "Не определена дата в активном календаре");
            error = true;
        }
        if(checkTime(timeLeave)){
            error = true;
            errors.put("dateError", "Не определена дата в активном календаре");
        }
        if (error) {
            return errors;
        }

        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.CALENDAR, calendar.getId().toString()));
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.COMMENT, comment));
        dealObjectAttrList.add(new DealObjectAttr(DealObjectAttrType.TIME_END, timeLeave));

        DealObject dealObject = new DealObject(bidRule, institution);

        bidObjectService.createBidObject(dealObject, dealObjectAttrList);


        return errors;
    }

    private boolean checkTime(String time) {
        return time.equals("__:__");
    }

}
