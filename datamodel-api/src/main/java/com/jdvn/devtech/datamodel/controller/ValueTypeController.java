package com.jdvn.devtech.datamodel.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.jdvn.devtech.datamodel.repository.ValueTypeRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValueType;
import com.jdvn.devtech.datamodel.view.ValueTypeExcel;
import com.jdvn.devtech.datamodel.view.ValueTypePdf;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/valuetypes/v1")
@Tag(name = "Value Type", description = "Value Type Management APIs")
public class ValueTypeController {
	@Autowired
	private ValueTypeRepository valueTypeRepository;

	@Operation(
			summary = "Retrieve all value type values", 
			description = "Get all value type objects. The response is a collection of value type objects.", 
			tags = {"Code Lists"})
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValueType.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Iterable<ValueType> getAllValueTypes() {
		return valueTypeRepository.findAll();
	}
	@Operation(
			summary = "Retrieve a value type by code", 
			description = "Get a value type object by specifying its code. The response is a value type object with code, display value, description and status.",
			tags = {"Search"})
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValueType.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@GetMapping("/find/{code}")
	public Optional<ValueType> findValueTypeByCode(@PathVariable String code) {
		return valueTypeRepository.findById(code);
	}
	@Operation(
			summary = "Update a value type by provide a code", 
			description = "Update a value type object by specifying its code and attribute. The response is a updated value type object.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValueType.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@PatchMapping("/update")
	public ValueType updateValueType(@RequestBody ValueType valueType) {
		return valueTypeRepository.save(valueType);
	}
	@Operation(
			summary = "Create a value type by provide a value type object", 
			description = "Create a value type object. The response is a list of most updated value type objects.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValueType.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@PostMapping("/create")
	public Iterable<ValueType> createValueType(@RequestBody ValueType valueType) {
		valueTypeRepository.save(valueType);
		return valueTypeRepository.findAll();
	}
	@Operation(
			summary = "Delete a value type by code", 
			description = "Delete a valuation unit category object by specifying its code.")
	@DeleteMapping("/delete/{code}")
	public void deleteValueType(@PathVariable String code) {
		valueTypeRepository.deleteById(code);
	}
	
	/*
	 * APIs to render views beside html or json view
	 * Pdf and Excel for example. 
	 * */
	@GetMapping(path ="/toExcel")
	public ModelAndView exportToExcel() {
	    ModelAndView mav = new ModelAndView();
	    mav.setView(new ValueTypeExcel());
	    List<ValueType> list= (List<ValueType>) valueTypeRepository.findAll();	    
	    mav.addObject("list", list);
	    return mav; 
	}
	@GetMapping(path ="/toPdf")
	public ModelAndView exportToPdf() {
	    ModelAndView mav = new ModelAndView();
	    mav.setView(new ValueTypePdf());
	    List<ValueType> list= (List<ValueType>) valueTypeRepository.findAll();	    
	    mav.addObject("list", list);
	    return mav; 
	}	
}