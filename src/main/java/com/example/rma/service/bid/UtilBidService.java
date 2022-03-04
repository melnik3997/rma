package com.example.rma.service.bid;

import com.example.rma.domain.Institution;
import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.bidRule.Transition;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Service
public class UtilBidService {
    @Autowired
    private CalendarService calendarService;

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private BidObjectService bidObjectService;

    public Calendar getCalendarAndCheck(String date, Institution institution, Map<String, String> errors){
        Boolean error = false;
        LocalDate dateD = null;
        try {
            dateD = LocalDate.parse(date, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        }catch (Exception e){
            error = true;
            errors.put("dateError", "Не корректно указана дата");
        }
        if(error){
            return null;
        }
        Calendar calendar = calendarService.findCalendarByDateAndInstitution(institution, dateD);

        if(calendar == null){
            errors.put("dateError", "Не определена дата в активном календаре");
            error = true;
        }else if(LocalDate.now().compareTo(dateD) > 0){
            error = true;
            errors.put("dateError", "Дата заявки не может быть меньше текущей даты");
        }
        return calendar;

    }


    public DealObject setEmployeeByDealObject(DealObject dealObject, Transition transition){
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

    private boolean checkTime(String time) {
        return time.equals("__:__");
    }
}
