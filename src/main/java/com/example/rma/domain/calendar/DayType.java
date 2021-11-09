package com.example.rma.domain.calendar;

import com.example.rma.domain.dto.WorkScheduleDto;

public enum DayType {
    WORK("рабочий"),
    OUTPUT("выходной") {
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            return workScheduleDto;
        }
    },
    HOLIDAY("праздничный"){
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            return workScheduleDto;
        }
    },
    PRE_HOLIDAY("предпраздничный"){
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(workScheduleDto.getWorkTime() - 1D);
            return workScheduleDto;
        }
    },
    VACATION("отпуск"),
    DAY_OFF("отгул");

    private final String name;

    DayType(String name){
        this.name = name;
    }

    public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto){
        return workScheduleDto;
    }

    public String getName() {
        return name;
    }
}
