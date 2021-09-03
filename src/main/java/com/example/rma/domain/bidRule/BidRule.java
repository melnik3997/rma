package com.example.rma.domain.bidRule;

import com.example.rma.domain.Enterprise;

import javax.persistence.*;


@Entity
@Table(name = "tBidRule")
public class BidRule {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String name;

    @Enumerated(EnumType.STRING)
    private BidType bidType;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "enterprise_id")
    private Enterprise enterprise;

    private boolean active;

    public BidRule() {

    }

    public BidRule(String name, BidType bidType, Enterprise enterprise) {
        this.name = name;
        this.bidType = bidType;
        this.enterprise = enterprise;
        this.active = false;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BidType getBidType() {
        return bidType;
    }

    public String getBidTypeName() {
        return bidType.getName();
    }

    public void setBidType(BidType bidType) {
        this.bidType = bidType;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }


}
