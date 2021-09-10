package com.example.rma.domain;

import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.calendar.Calendar;

import javax.persistence.*;
import java.time.LocalTime;

@Entity
@Table(name = "tWorkScheduleCorrect")
public class WorkScheduleCorrect {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "deal_object_id")
    private DealObject dealObject;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "calendar_id")
    private Calendar calendar;

    @Column(name = "time_begin", columnDefinition = "time without time zone")
    private LocalTime timeBegin;

    @Column(name = "time_finish", columnDefinition = "time without time zone")
    private LocalTime timeFinish;

    private String comment;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }

    public DealObject getDealObject() {
        return dealObject;
    }

    public void setDealObject(DealObject dealObject) {
        this.dealObject = dealObject;
    }

    public Calendar getCalendar() {
        return calendar;
    }

    public void setCalendar(Calendar calendar) {
        this.calendar = calendar;
    }

    public LocalTime getTimeBegin() {
        return timeBegin;
    }

    public void setTimeBegin(LocalTime timeBegin) {
        this.timeBegin = timeBegin;
    }

    public LocalTime getTimeFinish() {
        return timeFinish;
    }

    public void setTimeFinish(LocalTime timeFinish) {
        this.timeFinish = timeFinish;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
