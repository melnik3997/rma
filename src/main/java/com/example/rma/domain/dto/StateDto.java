package com.example.rma.domain.dto;

import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.State;
import com.example.rma.domain.bidRule.StateType;
import com.example.rma.domain.bidRule.Transition;

import java.util.ArrayList;
import java.util.List;

public class StateDto {

    private Long id;
    private BidRule bidRule;
    private String name;
    private String brief;
    private StateType stateType;
    private int number;
    private List<Transition> transitionList = new ArrayList<>();


    public StateDto(State state) {
        this.id = state.getId();
        this.bidRule = state.getBidRule();
        this.name = state.getName();
        this.brief = state.getBrief();
        this.stateType = state.getStateType();
        this.number = state.getNumber();
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public StateType getStateType() {
        return stateType;
    }

    public void setStateType(StateType stateType) {
        this.stateType = stateType;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public List<Transition> getTransitionList() {
        return transitionList;
    }

    public String getStateTypeName() {
        return stateType.getName();
    }

    public void setTransitionList(List<Transition> transitionList) {
        this.transitionList = transitionList;
    }
}
