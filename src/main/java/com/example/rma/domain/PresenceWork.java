package com.example.rma.domain;

import com.example.rma.domain.calendar.Calendar;

import javax.persistence.*;
import java.time.LocalTime;

@Entity
@Table(name = "tPresenceWork")
public class PresenceWork {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "calendar_id")
    private Calendar calendar;

    @Column(name = "time_begin", columnDefinition = "time without time zone")
    private LocalTime timeBegin;

    @Column(name = "time_finish", columnDefinition = "time without time zone")
    private LocalTime timeFinish;

    private boolean active;

    private int number;

    private long duration;

    public PresenceWork(Institution institution, Calendar calendar, LocalTime timeBegin) {
        this.institution = institution;
        this.calendar = calendar;
        this.timeBegin = timeBegin;
        this.active = true;
    }

    public PresenceWork() {
    }

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

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public long getDuration() {
        return duration;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }
}
