package com.jdvn.devtech.datamodel.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.jdvn.devtech.datamodel.repository.ValueTypeRepository;
import com.jdvn.devtech.datamodel.schema.preparation.ValueType;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/ValueTypes/v1")
public class ValueTypeController {
	@Autowired
	private ValueTypeRepository valueTypeRepository;
	
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Iterable<ValueType> getAllValueTypes() {
		return valueTypeRepository.findAll();
	}
	@GetMapping("/find/{code}")
	public Optional<ValueType> findValueTypeByCode(@PathVariable String code) {
		return valueTypeRepository.findById(code);
	}

	@PostMapping("/update")
	public ValueType updateValueType(@RequestBody ValueType valueType) {
		return valueTypeRepository.save(valueType);
	}

	@PostMapping("/create")
	public Iterable<ValueType> createValueType(@RequestBody ValueType valueType) {
		valueTypeRepository.save(valueType);
		return valueTypeRepository.findAll();
	}

	@DeleteMapping("/delete/{code}")
	public void deleteValueType(@PathVariable String code) {
		valueTypeRepository.deleteById(code);
	}
}