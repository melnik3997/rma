package com.example.rma.domain.bidRule.dto;

import com.example.rma.domain.Institution;
import com.example.rma.domain.bidRule.BidRule;
import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.bidRule.Protocol;
import com.example.rma.domain.bidRule.Transition;

import java.util.ArrayList;
import java.util.List;

public class DealObjectDto {

    private Long id;
    private BidRule bidRule;
    private Institution author;
    private Institution responsible;
    private Institution employee;
    private Protocol protocol;
    private List<Transition> availableTransitionList = new ArrayList<>();
    private List<Protocol> protocolList = new ArrayList<>();

    public DealObjectDto(DealObject dealObject) {
        this.id = dealObject.getId();
        this.bidRule = dealObject.getBidRule();
        this.author = dealObject.getAuthor();
        this.responsible = dealObject.getResponsible();
        this.protocol = dealObject.getProtocol();
        this.employee = dealObject.getEmployee();
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

    public Institution getAuthor() {
        return author;
    }

    public void setAuthor(Institution author) {
        this.author = author;
    }

    public Institution getResponsible() {
        return responsible;
    }

    public void setResponsible(Institution responsible) {
        this.responsible = responsible;
    }

    public Protocol getProtocol() {
        return protocol;
    }

    public void setProtocol(Protocol protocol) {
        this.protocol = protocol;
    }

    public List<Transition> getAvailableTransitionList() {
        return availableTransitionList;
    }

    public void setAvailableTransitionList(List<Transition> availableTransitionList) {
        this.availableTransitionList = availableTransitionList;
    }

    public List<Protocol> getProtocolList() {
        return protocolList;
    }

    public void setProtocolList(List<Protocol> protocolList) {
        this.protocolList = protocolList;
    }

    public Institution getEmployee() {
        return employee;
    }

    public void setEmployee(Institution employee) {
        this.employee = employee;
    }

    public String getBidRuleName() {
        return bidRule.getName();
    }
    public String getProtocolStateName() {
        return protocol.getTransition().getTargetStateName();
    }
    public String getAuthorFIO() {
        return author.getFIO();
    }
    public String getResponsibleFIO() {
        return responsible == null? "": responsible.getFIO();
    }
    public String getEmployeeFIO() {
        return employee.getFIO();
    }

}
