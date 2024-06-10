package com.jdvn.devtech.datamodel.utils;

import java.lang.reflect.Field;

import org.springframework.stereotype.Component;

@Component
public class FieldPatcher {
    public static void doPatchingFields(Object existingObj, Object dtoObj) throws IllegalAccessException {

        //Get the compiled version of the class
        Class<?> dtoClass = dtoObj.getClass();
        Field[] dtoFields = dtoClass.getDeclaredFields();
        
        Class<?> targetClass = existingObj.getClass();
        Field[] targetFields = targetClass.getDeclaredFields();
        
        for(Field dtoF : dtoFields){
            //If field is private
            dtoF.setAccessible(true);
            //If the value of the field not null then update
            Object value=dtoF.get(dtoObj);
            if(value!=null){
            	for(Field tf : targetFields) {
            		if (tf.getName().equals(dtoF.getName())) {
            			tf.setAccessible(true);
            			tf.set(existingObj,value); 
            			tf.setAccessible(false);
            			break;
            		}
            			           		
            	}
            }
            dtoF.setAccessible(false);
        }
    }
}