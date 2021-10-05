package com.example.rma.domain.bidRule;

import com.example.rma.domain.Institution;

import javax.persistence.*;

@Entity
@Table(name = "tDealObject")
public class DealObject {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "bid_rule_id")
    private BidRule bidRule;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "author_id")
    private Institution author;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "responsible_id")
    private Institution responsible;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "employee_id")
    private Institution employee;


    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "protocol_id")
    private Protocol protocol;


    public DealObject(BidRule bidRule, Institution author, Institution employee) {
        this.bidRule = bidRule;
        this.author = author;
        this.employee = employee;
    }

    public DealObject() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Institution getAuthor() {
        return author;
    }

    public String getAuthorFIO() {
        return author.getFIO();
    }

    public void setAuthor(Institution author) {
        this.author = author;
    }

    public BidRule getBidRule() {
        return bidRule;
    }

    public String getBidRuleName() {
        return bidRule.getName();
    }

    public void setBidRule(BidRule bidRule) {
        this.bidRule = bidRule;
    }

    public Protocol getProtocol() {
        return protocol;
    }

    public String getProtocolStateName() {
        return protocol.getTransition().getTargetStateName();
    }

    public void setProtocol(Protocol protocol) {
        this.protocol = protocol;
    }

    public Institution getResponsible() {
        return responsible;
    }

    public String getResponsibleFIO() {
        return responsible.getFIO();
    }

    public void setResponsible(Institution responsible) {
        this.responsible = responsible;
    }

    public Institution getEmployee() {
        return employee;
    }

    public void setEmployee(Institution employee) {
        this.employee = employee;
    }
}
