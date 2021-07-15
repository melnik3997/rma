package com.example.rma.controller;

import com.example.rma.domain.Institution;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ControllerUtils {

    static Map<String, String> getErrors(BindingResult bindingResult) {
        Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );

        Map<String, String> errorsMap = bindingResult.getFieldErrors().stream().collect(collector);
        return errorsMap;
    }

    static Map<String, Object> parsersAttribute(Object object) {
        Map<String,Object> model = new HashMap<>();

        for (Field field : object.getClass().getDeclaredFields()){
            try {
                Method fieldGetter = object.getClass().getMethod("get"+field.getName().substring(0,1).toUpperCase()+field.getName().substring(1) );
                model.put(field.getName(),fieldGetter.invoke(object) );
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            }
        }
        return model;
    }
}
