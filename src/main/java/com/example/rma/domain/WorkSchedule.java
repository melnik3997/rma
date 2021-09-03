package com.example.rma.domain;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "tWorkSchedule")
public class WorkSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;

    private Double workTime;

    private Double lunchBreak;

    private boolean lunchBreakIn;

    @Column(name = "time_begin", columnDefinition = "time without time zone")
    private LocalTime timeBegin;

    @Column(name = "time_finish", columnDefinition = "time without time zone")
    private LocalTime timeFinish;

    private boolean active;

    @Column(name = "date_start", columnDefinition = "DATE")
    private LocalDate dateStart;

    @Column(name = "date_end", columnDefinition = "DATE")
    private LocalDate dateEnd;


    public WorkSchedule(Institution institution, Double workTime, Double lunchBreak, boolean lunchBreakIn, LocalTime timeBegin, LocalTime timeFinish, boolean active) {
        this.institution = institution;
        this.workTime = workTime;
        this.lunchBreak = lunchBreak;
        this.lunchBreakIn = lunchBreakIn;
        this.timeBegin = timeBegin;
        this.timeFinish = timeFinish;
        this.active = active;
    }

    public WorkSchedule() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }

    public LocalDate getDateStart() {
        return dateStart;
    }

    public void setDateStart(LocalDate dateStart) {
        this.dateStart = dateStart;
    }

    public LocalDate getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(LocalDate dateEnd) {
        this.dateEnd = dateEnd;
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

    public Double getWorkTime() {
        return workTime;
    }

    public void setWorkTime(Double workTime) {
        this.workTime = workTime;
    }

    public Double getLunchBreak() {
        return lunchBreak;
    }

    public void setLunchBreak(Double lunchBreak) {
        this.lunchBreak = lunchBreak;
    }

    public boolean isLunchBreakIn() {
        return lunchBreakIn;
    }

    public void setLunchBreakIn(boolean lunchBreakIn) {
        this.lunchBreakIn = lunchBreakIn;
    }

    @Override
    public String toString() {
        return "WorkSchedule{" +
                "id=" + id +
                ", active=" + active +
                ", institution=" + institution.getId() +
                ", dateStart=" + dateStart +
                ", dateEnd=" + dateEnd +
                ", timeBegin=" + timeBegin +
                ", timeFinish=" + timeFinish +
                ", WorkTime=" + workTime +
                ", LunchBreak=" + lunchBreak +
                ", LunchBreakIn=" + lunchBreakIn +
                '}';
    }
}
