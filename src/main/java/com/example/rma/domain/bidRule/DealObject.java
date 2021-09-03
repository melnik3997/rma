package com.example.rma.domain.bidRule;

import javax.persistence.*;

@Entity
@Table(name = "tDealObject")
public class DealObject {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private Long objectId;

    @Enumerated(EnumType.STRING)
    private BidType bidType;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "bid_rule_id")
    private BidRule bidRule;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "protocol_id")
    private Protocol protocol;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getObjectId() {
        return objectId;
    }

    public void setObjectId(Long objectId) {
        this.objectId = objectId;
    }

    public BidType getBidType() {
        return bidType;
    }

    public void setBidType(BidType bidType) {
        this.bidType = bidType;
    }

    public BidRule getBidRule() {
        return bidRule;
    }

    public void setBidRule(BidRule bidRule) {
        this.bidRule = bidRule;
    }

    public Protocol getProtocol() {
        return protocol;
    }

    public void setProtocol(Protocol protocol) {
        this.protocol = protocol;
    }
}
