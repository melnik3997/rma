package com.example.rma.domain.calendar;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;
import java.time.LocalDate;

@Entity
@Table(name = "tCalendar")
public class Calendar {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "calendar_enterprise_id")
    private CalendarEnterprise calendarEnterprise;

    private Integer dateInt;

    private Integer monthInt;

    @Column(name = "date_d", columnDefinition = "DATE")
    private LocalDate dateD;

    @Column(name = "day_week")
    @Enumerated(EnumType.STRING)
    private DayWeek dayWeek;

    @Column(name = "day_type")
    @Enumerated(EnumType.STRING)
    private DayType dayType;

    private Integer numberWeek;

    public Calendar(LocalDate localDate, Integer dateInt, Integer monthInt){
        this.dateD = localDate;
        this.dateInt = dateInt;
        this.monthInt = monthInt;
    }

    public Calendar(){

    }

    public Integer getNumberWeek() {
        return numberWeek;
    }

    public void setNumberWeek(Integer numberWeek) {
        this.numberWeek = numberWeek;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public CalendarEnterprise getCalendarEnterprise() {
        return calendarEnterprise;
    }

    public void setCalendarEnterprise(CalendarEnterprise calendarEnterprise) {
        this.calendarEnterprise = calendarEnterprise;
    }

    public Integer getDateInt() {
        return dateInt;
    }

    public void setDateInt(Integer dateInt) {
        this.dateInt = dateInt;
    }

    public Integer getMonthInt() {
        return monthInt;
    }

    public void setMonthInt(Integer monthInt) {
        this.monthInt = monthInt;
    }

    public LocalDate getDateD() {
        return dateD;
    }

    public void setDateD(LocalDate dateD) {
        this.dateD = dateD;
    }

    public DayWeek getDayWeek() {
        return dayWeek;
    }

    public void setDayWeek(DayWeek dayWeek) {
        this.dayWeek = dayWeek;
    }

    public DayType getDayType() {
        return dayType;
    }

    public void setDayType(DayType dayType) {
        this.dayType = dayType;
    }

    @Override
    public String toString() {
        return "Calendar{" +
                "id=" + id +
                ", calendarEnterprise=" + calendarEnterprise +
                ", dateInt=" + dateInt +
                ", month=" + monthInt +
                ", date=" + dateD +
                ", dayWeek=" + dayWeek +
                ", dayType=" + dayType +
                '}';
    }
}
