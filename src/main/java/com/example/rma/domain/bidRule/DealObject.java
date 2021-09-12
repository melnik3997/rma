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

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "protocol_id")
    private Protocol protocol;


    public DealObject(BidRule bidRule, Institution author) {
        this.bidRule = bidRule;
        this.author = author;
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

    public void setAuthor(Institution author) {
        this.author = author;
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
