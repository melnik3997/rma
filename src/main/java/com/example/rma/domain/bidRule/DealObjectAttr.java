package com.example.rma.domain.bidRule;

import javax.persistence.*;

@Entity
@Table(name = "tDealObjectAttr")
public class DealObjectAttr {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "deal_object_id")
    private DealObject dealObject;

    @Enumerated(EnumType.STRING)
    private DealObjectAttrType dealObjectAttrType;

    private String valueAttr;

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

    public DealObjectAttrType getDealObjectAttrType() {
        return dealObjectAttrType;
    }

    public void setDealObjectAttrType(DealObjectAttrType dealObjectAttrType) {
        this.dealObjectAttrType = dealObjectAttrType;
    }

    public String getValueAttr() {
        return valueAttr;
    }

    public void setValueAttr(String valueAttr) {
        this.valueAttr = valueAttr;
    }
}
