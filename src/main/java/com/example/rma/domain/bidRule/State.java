package com.example.rma.domain.bidRule;

import javax.persistence.*;

@Entity
@Table(name = "tState")
public class State {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "bid_rule_id")
    private BidRule bidRule;

    private String name;

    private String brief;

    @Enumerated(EnumType.STRING)
    private StateType stateType;

    private int number;


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

    public static int compare(State s1, State s2) {
        if(s1.getNumber() > s2.getNumber())
            return 1;
        return -1;
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

    public String getStateTypeName() {
        return stateType.getName();
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
}
