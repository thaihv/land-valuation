package com.jdvn.devtech.datamodel.repository;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.jdvn.devtech.datamodel.DatamodelApplication;
import com.jdvn.devtech.datamodel.schema.valuation.ValueType;

@SpringBootTest(classes = DatamodelApplication.class)
public class ValueTypeRepositoryUnitTest {
	
	@Autowired
	private ValueTypeRepository valueTypeRepository;
	
	@Test
	public void checkCodeListValueType_is_active() {
		String type = "netPresentValue";
		ValueType value_type = valueTypeRepository.findById(type).get();
		char bActive = value_type.getStatus();
		
		assertEquals('i', bActive);
		assertEquals("Net Present Value", value_type.getDisplay_value());
	}

}