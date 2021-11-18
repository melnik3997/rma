package com.example.rma.domain.dto;


import com.example.rma.domain.Institution;
import com.example.rma.domain.Subdivision;

public class Node {

    private Long nodeId;
    private Long pid;
    private String brief;
    private String name;
    private Long enterpriseId;
    private Institution institution;


    public Node(Subdivision subdivision, Institution institution){
        this.nodeId = subdivision.getId();
        this.pid = subdivision.getParentId();
        this.brief = subdivision.getBrief();
        this.name = subdivision.getName();
        this.enterpriseId = subdivision.getEnterpriseId();
        this.institution = institution;
    }

    public Node(Long nodeId, Long pId, String brief, String name, Long enterpriseId) {
        this.nodeId = nodeId;
        this.pid = pId;
        this.brief = brief;
        this.name = name;
        this.enterpriseId = enterpriseId;
    }

    public Node() {

    }

    public Long getNodeId() {
        return nodeId;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public void setNodeId(Long nodeId) {
        this.nodeId = nodeId;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Institution getInstitution() {
        return institution;
    }

    public String getInstitutionFIO() {
        return institution.getFIO();
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }
/*
    @Override
    public String toString() {
        return "Node{" +
                "nodeId=" + nodeId +
                ", pid=" + pid +
                ", brief='" + brief + '\'' +
                ", name='" + name + '\'' +
                ", enterpriseId=" + enterpriseId +
                '}';
    }*/
}