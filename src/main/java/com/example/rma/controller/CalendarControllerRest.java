package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.calendar.DayType;
import com.example.rma.domain.calendar.dto.Day;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.service.UserService;
import com.example.rma.service.calendar.CalendarService;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping
public class CalendarControllerRest {

    @Autowired
    private UserService userService;

    @Autowired
    private CalendarService calendarService;

    @GetMapping("/calendarEnterprise")
    public List<Month> getCalendar(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        CalendarEnterprise calendarEnterprise = calendarService.findCalendarEnterpriseByInstitution(institution);

        List<Month> months = calendarService.getCalendarDtoForCalendarEnterprise(calendarEnterprise);

        return months;
    }

    @GetMapping("/calendarEnterprise/now")
    public Month getCalendarNow(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);

        return calendarService.getCalendarDtoNowByInstitution(institution);
    }

    @GetMapping("/calendarEnterprise/{calendarEnterprise}")
    public List<Month> getCalendarById(@AuthenticationPrincipal User user,
                                       @PathVariable CalendarEnterprise calendarEnterprise){
        System.out.println("requestGetCalendar "+ calendarEnterprise);
        List<Month> months = calendarService.getCalendarDtoForCalendarEnterprise(calendarEnterprise);

        return months;
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(method = RequestMethod.POST,
            value = "/calendarEnterprise")
    public List<Month> editCalendar(@AuthenticationPrincipal User user,
                                    @RequestBody RequestEditCalendar requestEditCalendar,
                                    HttpServletRequest request ){

        List<Calendar> calendarList = calendarService.findCalendarListByDayList(requestEditCalendar.getDay());

        calendarList.forEach(calendar -> calendar.setDayType(DayType.values()[requestEditCalendar.getDayType()-1]));

        calendarService.saveAll(calendarList);
        LocalDate date = LocalDate.now();

        Institution institution = userService.findInstitutionByUser(user);
        List<Month> months = calendarService.getCalendarDtoForYear(institution.getEnterprise(), CalendarType.getDefault(), date.getYear());

        return months;
    }

    static class RequestGetCalendar{
        @JsonProperty("year")
        private Integer year;

        @JsonProperty("calendarType")
        private Integer calendarType;

        @JsonProperty("enterpriseId")
        private Long enterpriseId;

        public Integer getYear() {
            return year;
        }

        public void setYear(Integer year) {
            this.year = year;
        }

        public Integer getCalendarType() {
            return calendarType;
        }

        public void setCalendarType(Integer calendarType) {
            this.calendarType = calendarType;
        }

        public Long getEnterpriseId() {
            return enterpriseId;
        }

        public void setEnterpriseId(Long enterpriseId) {
            this.enterpriseId = enterpriseId;
        }

        @Override
        public String toString() {
            return "RequestGetCalendar{" +
                    "year=" + year +
                    ", calendarType=" + calendarType +
                    ", enterpriseId=" + enterpriseId +
                    '}';
        }
    }

    static class RequestEditCalendar {
        @JsonProperty("dayList")
        public List<Day> day;
        @JsonProperty("dayType")
        public Integer dayType;

        public List<Day> getDay() {
            return day;
        }

        public void setDay(List<Day> day) {
            this.day = day;
        }

        public Integer getDayType() {
            return dayType;
        }

        public void setDayType(Integer dayType) {
            this.dayType = dayType;
        }
    }
}


