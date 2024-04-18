package com.example.rma.domain.calendar;

import com.example.rma.domain.Institution;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "t_Calendar_Close")
public class CalendarClose {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "calendar_id")
    private Calendar calendar;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;

    @Column(columnDefinition = "timestamp without time zone")
    private LocalDateTime dateProtocol;

    public CalendarClose( Calendar calendar, Institution institution, LocalDateTime dateProtocol) {
        this.calendar = calendar;
        this.institution = institution;
        this.dateProtocol = dateProtocol;
    }

    public CalendarClose() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Calendar getCalendar() {
        return calendar;
    }

    public void setCalendar(Calendar calendar) {
        this.calendar = calendar;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }

    public LocalDateTime getDateProtocol() {
        return dateProtocol;
    }

    public void setDateProtocol(LocalDateTime dateProtocol) {
        this.dateProtocol = dateProtocol;
    }
}
