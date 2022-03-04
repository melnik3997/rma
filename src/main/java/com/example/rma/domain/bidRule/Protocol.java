package com.example.rma.domain.bidRule;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tProtocol")
public class Protocol {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "object_id")
    private DealObject dealObject;

    @Column(columnDefinition = "timestamp without time zone")
    private LocalDateTime dateProtocol;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "transition_id")
    private Transition transition;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "responsible_id")
    private Institution responsible;

    public Protocol(DealObject dealObject, LocalDateTime dateProtocol, Transition transition, User user, Institution responsible) {
        this.dealObject = dealObject;
        this.dateProtocol = dateProtocol;
        this.transition = transition;
        this.user = user;
        this.responsible = responsible;
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

    public LocalDateTime getDateProtocol() {
        return dateProtocol;
    }

    public void setDateProtocol(LocalDateTime dateProtocol) {
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

    public String getUserName() {
        return user.getUsername();
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getTransitionActionName()  {
        return transition.getActionName();
    }
    public String getTransitionTargetStateName()  {
        return transition.getTargetStateName();
    }

    public Institution getResponsible() {
        return responsible;
    }

    public void setResponsible(Institution responsible) {
        this.responsible = responsible;
    }



}
