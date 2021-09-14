package com.example.rma.domain.bidRule;

import com.example.rma.domain.User;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "tProtocol")
public class Protocol {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "object_id")
    private DealObject dealObject;

    @Column(columnDefinition = "DATE")
    private LocalDate dateProtocol;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "transition_id")
    private Transition transition;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "user_id")
    private User user;

    public Protocol(DealObject dealObject, LocalDate dateProtocol, Transition transition, User user) {
        this.dealObject = dealObject;
        this.dateProtocol = dateProtocol;
        this.transition = transition;
        this.user = user;
    }

    public Protocol() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public DealObject getDealObject() {
        return dealObject;
    }

    public void setDealObject(DealObject dealObject) {
        this.dealObject = dealObject;
    }

    public LocalDate getDateProtocol() {
        return dateProtocol;
    }

    public void setDateProtocol(LocalDate dateProtocol) {
        this.dateProtocol = dateProtocol;
    }

    public Transition getTransition() {
        return transition;
    }

    public void setTransition(Transition transition) {
        this.transition = transition;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
