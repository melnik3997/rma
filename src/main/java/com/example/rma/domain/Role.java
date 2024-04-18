package com.example.rma.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER,
    ADMIN,
    LIEDER,
    MANAGER;

    @Override
    public String getAuthority() {
        return name();
    }
}
