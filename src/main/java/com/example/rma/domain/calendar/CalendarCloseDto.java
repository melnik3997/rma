package com.example.rma.domain.calendar;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class CalendarCloseDto implements Serializable {
    private final Long id;
    private final Integer calendarMonthInt;
    private final LocalDate calendarDateD;
    private final DayWeek calendarDayWeek;
    private final LocalDateTime dateProtocol;
    private final String institutionFullName;

    public CalendarCloseDto(CalendarClose calendarClose, Calendar calendar) {
        this.id = calendarClose.getId();
        this.calendarMonthInt = calendar.getMonthInt();
        this.calendarDateD = calendar.getDateD();
        this.calendarDayWeek = calendar.getDayWeek();
        this.dateProtocol = calendarClose.getDateProtocol();
        this.institutionFullName = calendarClose.getInstitution().getFullName();
    }

    public Long getId() {
        return id;
    }

    public Integer getCalendarMonthInt() {
        return calendarMonthInt;
    }

    public LocalDate getCalendarDateD() {
        return calendarDateD;
    }

    public DayWeek getCalendarDayWeek() {
        return calendarDayWeek;
    }

    public String getCalendarDayWeekName() {
        return calendarDayWeek.getName();
    }

    public LocalDateTime getDateProtocol() {
        return dateProtocol;
    }

    public String getInstitutionFullName() {
        return institutionFullName;
    }
}
