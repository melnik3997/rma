package com.example.rma.domain.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.awt.*;

public class ChartDto {
    @JsonIgnore
    private Long  id;
    private String label;
    private String borderColor;
    private String backgroundColor;
    private Object[] data;

    public ChartDto(Long id, String label, String borderColor, String backgroundColor) {
        this.id = id;
        this.label = label;
        this.borderColor = borderColor;
        this.backgroundColor = backgroundColor;
    }

    public ChartDto(Long id, String label, Object[] data) {
        this.id = id;
        this.label = label;
        this.borderColor = randomColor();
        this.backgroundColor = randomColor();
        this.data = data;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getBorderColor() {
        return borderColor;
    }

    public void setBorderColor(String borderColor) {
        this.borderColor = borderColor;
    }

    public String getBackgroundColor() {
        return backgroundColor;
    }

    public void setBackgroundColor(String backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public Object[] getData() {
        return data;
    }

    public void setData(Object[] data) {
        this.data = data;
    }

    private static String randomColor(){
        int red = (int) (Math.random() * 256);
        int green = (int) (Math.random() * 256);
        int blue = (int) (Math.random() * 256);
        return String.format("#%02x%02x%02x", red, green, blue);

    }
}
