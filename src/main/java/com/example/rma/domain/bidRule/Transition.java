package com.example.rma.domain.bidRule;

import com.example.rma.domain.Institution;

import javax.persistence.*;

@Entity
@Table(name = "tTransition")
public class Transition {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "bid_rule_id")
    private BidRule bidRule;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "source_state_id")
    private State sourceState;

    private String actionName;

    @Enumerated(EnumType.STRING)
    private ActionType actionType;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "target_state_id")
    private State targetState;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;


    public Transition() {
    }

    public Transition(Long id, BidRule bidRule, State sourceState, String actionName, ActionType actionType, State targetState, Institution institution) {
        this.id = id;
        this.bidRule = bidRule;
        this.sourceState = sourceState;
        this.actionName = actionName;
        this.actionType = actionType;
        this.targetState = targetState;
        this.institution = institution;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BidRule getBidRule() {
        return bidRule;
    }

    public void setBidRule(BidRule bidRule) {
        this.bidRule = bidRule;
    }

    public State getSourceState() {
        return sourceState;
    }

    public Long getSourceStateId() {
        return sourceState.getId();
    }

    public void setSourceState(State sourceState) {
        this.sourceState = sourceState;
    }

    public String getActionName() {
        return actionName;
    }

    public void setActionName(String actionName) {
        this.actionName = actionName;
    }

    public ActionType getActionType() {
        return actionType;
    }

    public String getActionTypeName() {
        return actionType.getName();
    }

    public void setActionType(ActionType actionType) {
        this.actionType = actionType;
    }

    public State getTargetState() {
        return targetState;
    }

    public String getTargetStateName() {
        return targetState.getName();
    }

    public String getTargetStateTypeName() {
        return targetState.getStateTypeName();
    }


    public Long getTargetStateId() {
        return targetState.getId();
    }

    public void setTargetState(State targetState) {
        this.targetState = targetState;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
}
