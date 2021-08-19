package com.example.rma.domain.calendar;

import com.example.rma.domain.Enterprise;

import javax.persistence.*;

@Entity
@Table(name = "tCalendarEnterprise")
public class CalendarEnterprise {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "enterprise_id")
    private Enterprise enterprise;

    @Column(name = "calendar_type")
    @Enumerated(EnumType.STRING)
    private CalendarType calendarType;

    private Integer yearInt;

    public CalendarEnterprise(){}

    public CalendarEnterprise(Enterprise enterprise, CalendarType calendarType, Integer yearInt) {
        this.enterprise = enterprise;
        this.calendarType = calendarType;
        this.yearInt = yearInt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public CalendarType getCalendarType() {
        return calendarType;
    }

    public String getCalendarTypeString() {
        return calendarType.getName();
    }

    public void setCalendarType(CalendarType calendarType) {
        this.calendarType = calendarType;
    }

    public Integer getYearInt() {
        return yearInt;
    }

    public void setYearInt(Integer yearInt) {
        this.yearInt = yearInt;
    }

    @Override
    public String toString() {
        return "CalendarEnterprise{" +
                "id=" + id +
                ", enterprise=" + enterprise.getName() +
                ", calendarType=" + calendarType +
                ", year=" + yearInt +
                '}';
    }
}
