package com.example.rma.domain;

public enum PostType {
    engineer("Инженер"),
    development("Программист"),
    tester("Тестеровщик"),
    intruder("Внедренец"),
    team_leader("Руководитель команды"),
    analyst("Аналитик"),
    director("Директор"),
    accountant("Бухгалтер"),
    personnel_manager("Менеджер по персоналу"),
    office_manager("Офис менеджер");

    private final String name;

    PostType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
