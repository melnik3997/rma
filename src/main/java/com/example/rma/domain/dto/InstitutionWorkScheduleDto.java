package com.example.rma.domain.dto;

import java.util.ArrayList;
import java.util.List;

public class InstitutionWorkScheduleDto {

    private Long id;
    private String fio;
    private List<WorkScheduleDto> workScheduleDtoList = new ArrayList<>();

    public InstitutionWorkScheduleDto(Long id, String fio, List<WorkScheduleDto> workScheduleDtoList) {
        this.id = id;
        this.fio = fio;
        this.workScheduleDtoList = workScheduleDtoList;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFio() {
        return fio;
    }

    public void setFio(String fio) {
        this.fio = fio;
    }

    public List<WorkScheduleDto> getWorkScheduleDtoList() {
        return workScheduleDtoList;
    }

    public void setWorkScheduleDtoList(List<WorkScheduleDto> workScheduleDtoList) {
        this.workScheduleDtoList = workScheduleDtoList;
    }
}
