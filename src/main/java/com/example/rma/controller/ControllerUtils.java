package com.example.rma.controller;

import com.example.rma.domain.Institution;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import javax.servlet.http.HttpServletRequest;
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
    public static boolean checkErrorBinding(BindingResult bindingResult, Model model ){
        boolean error = false;
        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            if(errorsMap.size() != 0){
                error = true;
            }
        }
        return error;
    }

    static Map<String, Object> parsersAttribute(Object object) {
        Map<String,Object> model = new HashMap<>();

        for (Field field : object.getClass().getDeclaredFields()){
            try {
                Method fieldGetter;
                if (field.getType().getName().equals("boolean")){
                    fieldGetter = object.getClass().getMethod("is"+field.getName().substring(0,1).toUpperCase()+field.getName().substring(1) );
                }else {
                    fieldGetter = object.getClass().getMethod("get"+field.getName().substring(0,1).toUpperCase()+field.getName().substring(1) );
                }
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

    public static String getQueryUrl(HttpServletRequest request) {
        String query = request.getQueryString();
        if (query != null && !query.isEmpty()) {
            query = deleteParam(query, "size");
            query = deleteParam(query, "page");
        }
        query = query != null && !query.isEmpty() ? "?"+ query : "";
        return query;
    }

    private static String deleteParam(String s, String p){
        String n = "";
        String k = "";
        while (s.contains(p)){
            int beginIndex = s.indexOf(p) == 0 ? s.indexOf(p) : s.indexOf(p) - 1;
            n = s.substring(0, beginIndex);
            k = s.substring(beginIndex + 1);
            int endIndex = k.indexOf("&");
            if(endIndex != -1) {
                k = k.substring(endIndex);
            }else {
                k = "";
            }
            s = n + k;
        }
        return s;
    }
}
