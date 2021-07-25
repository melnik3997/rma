package com.example.rma.domain;

public enum PostType {
    engineer("Инженер"),
    development("Программист"),
    tester("Тестеровщик"),
    intruder("Внедренец"),
    team_leader("Руководитель команды"),
    analyst("Аналитик"),
    director("Директор");

    private final String name;

    PostType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
