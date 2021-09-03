package com.example.rma.domain.bidRule;

public enum ActionType {

    VERIFY("верифицировать"),
    CREATE("создать"),
    PROCESS("в обработку");

    private final String name;

    ActionType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
