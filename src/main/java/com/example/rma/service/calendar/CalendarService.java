package com.example.rma.service.calendar;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.calendar.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.dto.Day;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.domain.calendar.dto.Week;
import com.example.rma.repository.calendar.CalendarEnterpriseRepo;
import com.example.rma.repository.calendar.CalendarRepo;
import com.example.rma.service.SettingsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.*;

@Service
public class CalendarService {

    @Autowired
    private CalendarEnterpriseRepo calendarEnterpriseRepo;

    @Autowired
    private CalendarRepo calendarRepo;

    @Autowired
    private SettingsService settingsService;


    public List<LocalDate> getDateForYear(String year){
        List<LocalDate> result = new ArrayList<>();
        LocalDate dateStart = getDateFormat(year + "-01-01");
        LocalDate dateEnd = getDateFormat(year + "-12-31");

        while (!dateStart.isAfter(dateEnd)){
            result.add(dateStart);
            dateStart = dateStart.plusDays(1);
        }
        return result;
    }

    public LocalDate getDateFormat(String date){
        return LocalDate.parse(date);
    }

    public List<Calendar> getCalendarForYear(String year, CalendarEnterprise calendarEnterprise){
        WeekFields weekFields = WeekFields.ISO;
        List<Calendar> calendarList = new ArrayList<>();
        boolean SATURDAY_DAY_OFF = settingsService.getBooleanSettingsBySysName("SATURDAY_DAY_OFF");
        boolean SUNDAY_DAY_OFF = settingsService.getBooleanSettingsBySysName("SUNDAY_DAY_OFF");
        //создаем список дат в году
        List<LocalDate> localDateList = getDateForYear(year);
        //обработка дат
        for (LocalDate date : localDateList) {
            //формируем день календаря
            Calendar calendar = new Calendar(date, Integer.parseInt(date.format(DateTimeFormatter.BASIC_ISO_DATE)),date.getMonth().getValue() );
            //определяем рабочий или не рабочий день
            if((date.getDayOfWeek().getValue() == 6 && SATURDAY_DAY_OFF) || (date.getDayOfWeek().getValue() == 7 && SUNDAY_DAY_OFF)  ){
                calendar.setDayType(DayType.OUTPUT);
            }else {
                calendar.setDayType(DayType.WORK);
            }
            //определяем номер недели
            int numberWeek = date.get(weekFields.weekOfWeekBasedYear());
            calendar.setNumberWeek(numberWeek);
            //определяем день недели
            calendar.setDayWeek(DayWeek.valueOf(date.getDayOfWeek().name()));
            //запись календаря
            calendar.setCalendarEnterprise(calendarEnterprise);
            calendarList.add(calendar);
        }
        return calendarList;
    }

    @Transactional
    public Map<String, String> createCalendarEnterprise(Enterprise enterprise, CalendarType calendarType, Integer yearInt, boolean activeCalendar){
        Map<String, String> result = new HashMap<>();
        boolean checkCalendarEnterprise = checkCalendarEnterprise(enterprise, calendarType, yearInt);
        int minYear = settingsService.getIntSettingsBySysName("MIN_YEAR");
        int maxYear = settingsService.getIntSettingsBySysName("MAX_YEAR");
        if(minYear == 0 || maxYear == 0) {
            result.put("errorCreate", "Отсутсвует настройка MIN_YEAR или MAX_YEAR" );
            return result;
        }
        if(yearInt < minYear || yearInt > maxYear){
            result.put("errorYear", "Не корректное значение года" );
            return result;
        }

        if(checkCalendarEnterprise){
            result.put("errorCreate", "У данного предприятия уже есть календарь" );
            return result;
        }

        if(activeCalendar) {
            CalendarEnterprise calendarEnterprise = findByEnterpriseAndCalendarTypeAndActive(enterprise, calendarType, true);
            if(calendarEnterprise != null) {
                calendarEnterprise.setActive(false);
                calendarEnterpriseRepo.save(calendarEnterprise);
            }
        }

        CalendarEnterprise calendarEnterprise = new CalendarEnterprise(enterprise, calendarType, yearInt, activeCalendar);

        calendarEnterprise = calendarEnterpriseRepo.save(calendarEnterprise);

        List<Calendar> calendarList = getCalendarForYear(yearInt.toString(), calendarEnterprise );
        List<Calendar> calendarListDb = calendarRepo.saveAll(calendarList);

        return result;

    }

    public List<Month> getCalendarDtoForYear(Enterprise enterprise, CalendarType calendarType, Integer yearInt){
        CalendarEnterprise calendarEnterprise = findByEnterpriseAndCalendarTypeAndYear(enterprise, calendarType, yearInt);

        return getCalendarDtoForCalendarEnterprise(calendarEnterprise);
    }


    public List<Month> getCalendarDtoForCalendarEnterprise(CalendarEnterprise calendarEnterprise){
        List<Month> months = new ArrayList<>();
        for (int i = 1; i <= 12 ; i++) {
            months.add(new Month(i,getRusNameMonthByNumber(i), getWeekList(calendarEnterprise, i)));
        }
        return months;
    }

    public Month getCalendarDtoNowByInstitution(Institution institution){
        CalendarEnterprise calendarEnterprise = findCalendarEnterpriseByInstitution(institution);

        return new Month(LocalDate.now().getMonth().getValue(),getRusNameMonthByNumber(LocalDate.now().getMonth().getValue()), getWeekList(calendarEnterprise, LocalDate.now().getMonth().getValue()));

    }

    public List<Week> getWeekList(CalendarEnterprise calendarEnterprise, Integer numberMonth){
        //получаем список недель в месяце
        List<Week> weeks = calendarRepo.findWeekByCalendarEnterpriseAndMonth(calendarEnterprise, numberMonth);
        //сортируем первый и последний месяц
        if(numberMonth == 1 || numberMonth == 12){
            weeks = orderByWeekList(weeks, numberMonth);
        }
        int i = 0;
        //обрабатываем список недель и добавляем в них дни
        for (Week week : weeks ) {
            //список жней в неделе
            List<Day> days = calendarRepo.findDayByCalendarEnterpriseAndMonth(calendarEnterprise, numberMonth, week.getNumberWeek());
            //определяем номер дня
            days.forEach(day -> day.setDay(Integer.parseInt(day.getDay().toString().substring(6))));
            //заполняем недостающие дни до 7
            if(i == 0){
                //первая неделя в начало
                while (days.size() < 7){
                    days.add(0, new Day());
                }
            }else{
                //последующие в конец
                while (days.size() < 7){
                    days.add(new Day());
                }
            }
            //добавляем список дней в неделю
            week.setDayList(days);
            i++;
        }
        return weeks;
    }

    public List<Week> orderByWeekList(List<Week> weekList, int number){
        int min = weekList.get(0).getNumberWeek() ;
        int max = weekList.get(weekList.size()-1).getNumberWeek() ;
        int delta = max - min;
        if(Math.abs(delta) > 10){
            if(number == 1){
                weekList.add(0, weekList.get(weekList.size()-1));
                weekList.remove(weekList.size()-1);

            }else{
                weekList.add( weekList.get(0));
                weekList.remove(0);
            }
        }
        return weekList;
    }


    public CalendarEnterprise findByEnterpriseAndCalendarTypeAndYear(Enterprise enterprise, CalendarType calendarType, Integer yearInt){
        return calendarEnterpriseRepo.findByEnterpriseAndCalendarTypeAndYearInt(enterprise, calendarType, yearInt);
    }

    public CalendarEnterprise findByEnterpriseAndCalendarTypeAndActive(Enterprise enterprise, CalendarType calendarType, boolean active){
        return calendarEnterpriseRepo.findByEnterpriseAndCalendarTypeAndActive(enterprise, calendarType, active);
    }

    public List<CalendarEnterprise> findCalendarEnterpriseByEnterprise(Enterprise enterprise){
        return calendarEnterpriseRepo.findByEnterprise(enterprise, Sort.by(Sort.Direction.DESC, "active","yearInt"));
    }

    public List<Calendar> findByCalendarEnterprise (CalendarEnterprise calendarEnterprise){
        return calendarRepo.findByCalendarEnterprise(calendarEnterprise, Sort.by(Sort.Direction.DESC, "dateInt"));
    }

    public List<Calendar> findByCalendarEnterpriseAndNumberWeek (CalendarEnterprise calendarEnterprise, Integer numberWeek){
        return calendarRepo.findByCalendarEnterpriseAndNumberWeek(calendarEnterprise, numberWeek, Sort.by(Sort.Direction.ASC, "dateInt"));
    }

    private boolean checkCalendarEnterprise(Enterprise enterprise, CalendarType calendarType, Integer yearInt) {
        CalendarEnterprise calendarEnterprise = findByEnterpriseAndCalendarTypeAndYear(enterprise, calendarType, yearInt);
        return !(calendarEnterprise == null);
    }


    public String getRusNameMonthByNumber(Integer number){
        String name = "";
        switch (number){
            case 1:
                name = "Январь";
                break;
            case 2:
                name = "Февраль";
                break;
            case 3:
                name = "Март";
                break;
            case 4:
                name = "Апрель";
                break;
            case 5:
                name = "Май";
                break;
            case 6:
                name = "Июнь";
                break;
            case 7:
                name = "Июль";
                break;
            case 8:
                name = "Август";
                break;
            case 9:
                name = "Сентябрь";
                break;
            case 10:
                name = "Октябрь";
                break;
            case 11:
                name = "Ноябрь";
                break;
            case 12:
                name = "Декабрь";
                break;
        }
        return name;

    }

    public String getRusNameMonthRodByNumber(Integer number){
        String name = "";
        switch (number){
            case 1:
                name = "Января";
                break;
            case 2:
                name = "Февраля";
                break;
            case 3:
                name = "Марта";
                break;
            case 4:
                name = "Апреля";
                break;
            case 5:
                name = "Мая";
                break;
            case 6:
                name = "Июня";
                break;
            case 7:
                name = "Июля";
                break;
            case 8:
                name = "Августа";
                break;
            case 9:
                name = "Сентября";
                break;
            case 10:
                name = "Октября";
                break;
            case 11:
                name = "Ноября";
                break;
            case 12:
                name = "Декабря";
                break;
        }
        return name;

    }

    public Calendar findCalendarByNowDateAndInstitution(Institution institution){
        LocalDate date = LocalDate.now();
        CalendarEnterprise calendarEnterprise = findCalendarEnterpriseByInstitution(institution);
        return calendarRepo.findByCalendarEnterpriseAndDateD(calendarEnterprise, date);
    }
    public Calendar findCalendarByDateAndInstitution(Institution institution, LocalDate date){
        if(date == null){
            return null;
        }
        CalendarEnterprise calendarEnterprise = findCalendarEnterpriseByInstitution(institution);
        return calendarRepo.findByCalendarEnterpriseAndDateD(calendarEnterprise, date);
    }

    public CalendarEnterprise findCalendarEnterpriseByInstitution(Institution institution){
        return findByEnterpriseAndCalendarTypeAndActive(institution.getEnterprise(), CalendarType.getDefault(), true);
    }

    public Calendar findCalendarById(Long id){
        return  calendarRepo.findById(id).orElse(null);
    }

    public List<Calendar> findCalendarListByDayList(List<Day> days){

        List<Calendar> calendarList = new ArrayList<>();
        for (Day day: days ) {
            calendarList.add(findCalendarById(day.getId()));
        }
        return calendarList;
    }


    public void saveAll(List<Calendar> calendarList){
        calendarRepo.saveAll(calendarList);
    }
}
