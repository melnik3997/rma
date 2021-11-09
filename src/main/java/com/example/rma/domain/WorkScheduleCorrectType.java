package com.example.rma.domain;

import com.example.rma.domain.calendar.DayType;
import com.example.rma.domain.dto.WorkScheduleDto;

public enum WorkScheduleCorrectType {

    LEAVE_EARLY("уйти раньше"){
        @Override
        public WorkScheduleDto correct(WorkScheduleDto workScheduleDto, WorkScheduleCorrect workScheduleCorrect) {
            workScheduleDto.setTimeFinish(workScheduleCorrect.getTimeFinish());
            return workScheduleDto;
        }
    },
    TIME_OFF("отгул"){
        @Override
        public WorkScheduleDto correct(WorkScheduleDto workScheduleDto, WorkScheduleCorrect workScheduleCorrect) {
            workScheduleDto.setDayType(DayType.DAY_OFF);
            workScheduleDto.setWorkTime(0D);
            return workScheduleDto;
        }
    },
    VACATION("отпуск"){
        @Override
        public WorkScheduleDto correct(WorkScheduleDto workScheduleDto, WorkScheduleCorrect workScheduleCorrect) {
            workScheduleDto.setDayType(DayType.VACATION);
            workScheduleDto.setWorkTime(0D);
            return workScheduleDto;
        }
    };

    private final String name;

    public WorkScheduleDto correct(WorkScheduleDto workScheduleDto, WorkScheduleCorrect workScheduleCorrect){
        return workScheduleDto;
    }

    WorkScheduleCorrectType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
