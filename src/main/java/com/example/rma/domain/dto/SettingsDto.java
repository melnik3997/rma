package com.example.rma.domain.dto;


import com.example.rma.repository.SettingsRepo;
import org.springframework.beans.factory.annotation.Autowired;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

public class SettingsDto {


    private Long sId;

    private String sysName;

    private String type;

    private String val;

    public SettingsDto(Long sId, String sysName, String type, String val) {
        this.sId = sId;
        this.sysName = sysName;
        this.type = type;
        this.val = val;
    }

    public SettingsDto() {
    }

    public Long getsId() {
        return sId;
    }

    public void setsId(Long sId) {
        this.sId = sId;
    }

    public String getSysName() {
        return sysName;
    }

    public void setSysName(String sysName) {
        this.sysName = sysName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    @Override
    public String toString() {
        return "SettingsDto{" +
                "sId=" + sId +
                ", sysName='" + sysName + '\'' +
                ", type='" + type + '\'' +
                ", val='" + val + '\'' +
                '}';
    }
}
