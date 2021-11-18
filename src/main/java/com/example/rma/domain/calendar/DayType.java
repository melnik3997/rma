package com.example.rma.domain.calendar;

import com.example.rma.domain.dto.WorkScheduleDto;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public enum DayType {
    WORK("рабочий"),
    OUTPUT("выходной") {
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            workScheduleDto.setObligatoryWorkTime(0D);
            workScheduleDto.setTimeBegin( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            workScheduleDto.setTimeFinish( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            return workScheduleDto;
        }
    },
    HOLIDAY("праздничный"){
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            workScheduleDto.setObligatoryWorkTime(0D);
            workScheduleDto.setTimeBegin( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            workScheduleDto.setTimeFinish( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
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
    VACATION("отпуск"){
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            workScheduleDto.setObligatoryWorkTime(0D);
            workScheduleDto.setTimeBegin( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            workScheduleDto.setTimeFinish( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            return workScheduleDto;
        }
    },
    DAY_OFF("отгул"){
        @Override
        public WorkScheduleDto correctTimeWork(WorkScheduleDto workScheduleDto) {
            workScheduleDto.setWorkTime(0D);
            workScheduleDto.setObligatoryWorkTime(0D);
            workScheduleDto.setTimeBegin( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            workScheduleDto.setTimeFinish( LocalTime.parse("00:00", DateTimeFormatter.ISO_LOCAL_TIME));
            return workScheduleDto;
        }
    }
    ;

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
