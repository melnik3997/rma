package com.example.rma.service;

import com.example.rma.domain.Institution;
import com.example.rma.domain.PresenceWork;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.PresenceWorkRepo;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import java.time.Duration;
import java.time.LocalTime;

@Service
public class PresenceWorkService {

    @Autowired
    private PresenceWorkRepo presenceWorkRepo;

    @Autowired
    private CalendarService calendarService;


    private PresenceWork save(PresenceWork presenceWork){
        return presenceWorkRepo.save(presenceWork);
    }

    public PresenceWork create(  Institution institution, Calendar calendar, LocalTime timeBegin){
        PresenceWork presenceWork = new PresenceWork(institution, calendar, timeBegin);
        presenceWork.setNumber(getNumber(presenceWork.getInstitution(), presenceWork.getCalendar()));
        return save(presenceWork);
    }

    public PresenceWork close(PresenceWork presenceWork, LocalTime timeFinish) throws BusinessException {
        long duration = Duration.between(presenceWork.getTimeBegin(), timeFinish).getSeconds();
        if(duration < 0){
            throw new BusinessException("Дата начала меньше даты окончания");
        }
        presenceWork.setActive(false);
        presenceWork.setTimeFinish(timeFinish);
        presenceWork.setDuration(duration);
        save(presenceWork);
        return presenceWork;
    }

    /**
     * Производит начало/конец работы сотрудника
     * @param institution
     * @return
     */
    public PresenceWork action(Institution institution, LocalTime time) throws BusinessException {
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        // пытаемся найти текущий
        PresenceWork presenceWork = getActiveNow(institution);
        System.out.println("presenceWork " + presenceWork);
        if (presenceWork == null){
            presenceWork = create(institution, calendar, time);
        }else {
            presenceWork = close(presenceWork, time);
        }
        return presenceWork;

    }

    public PresenceWork getActiveNow(Institution institution){
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return getActive(institution, calendar);
    }

    public PresenceWork getActive(Institution institution, Calendar calendar){
        return presenceWorkRepo.findByInstitutionAndCalendarAndActive(institution, calendar, true);
    }

    public boolean isActive(Institution institution, Calendar calendar){
        return presenceWorkRepo.findByInstitutionAndCalendarAndActive(institution, calendar, true) != null;
    }

    public int getNumber(Institution institution, Calendar calendar){
        int i = 0;
        i = presenceWorkRepo.findMaxNumberByInstitutionAndCalendar(institution, calendar);
        i ++;
        return i;
    }
}
