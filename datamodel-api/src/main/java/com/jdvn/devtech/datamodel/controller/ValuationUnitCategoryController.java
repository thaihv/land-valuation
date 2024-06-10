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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.jdvn.devtech.datamodel.dto.UnitCategoryAttributesDTO;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;
import com.jdvn.devtech.datamodel.service.ValuationUnitCategoryService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/v1/vu-categories")
@Tag(name = "Valuation Unit Categories", description = "Valuation Technical Object Categoty Management APIs")
public class ValuationUnitCategoryController {
	
	@Autowired
	private ValuationUnitCategoryService valuationUnitCategoryService;
	
	@Operation(
			summary = "Retrieve valuation unit category objects. It can be using a filter to do search", 
			description = "Get valuation unit category objects. The response is a collection of valuation unit category objects.", 
			tags = {"Code Lists"})
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })	
	@GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<ValuationUnitCategory> getValuationUnitCategories(@RequestParam(defaultValue = "empty") String code, @RequestParam(defaultValue = "empty") String name, @RequestParam (defaultValue = "0") int from, @RequestParam (defaultValue = "10") int to) {
		if (!code.equals("empty")) {
			Optional<ValuationUnitCategory> vu= valuationUnitCategoryService.findByCategoryCode(code);
			if (vu.isPresent()) {
				return List.of(vu.get());
			}
		}
		if (!name.equals("empty")) {
			return valuationUnitCategoryService.findByCategoryName(name, from, to);	
		}
		return valuationUnitCategoryService.findAllCategories();
	}
	@Operation(
			summary = "Update a valuation unit category by provide whole object information. If the object is not existing then creating new one", 
			description = "Update a valuation unit category object by specifying its code and attribute. The response is a updated valuation unit category object.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })		
	@PutMapping
	public ValuationUnitCategory updateValuationUnitCategoryByWholeObject(@RequestBody UnitCategoryAttributesDTO attrs) {
		return valuationUnitCategoryService.updateValuationUnitCategoryAttributes(attrs);
	}
	
	@Operation(
			summary = "Update a valuation unit category by provide code and attributes", 
			description = "Update a valuation unit category object by specifying its code and few attributes. The response is a updated valuation unit category object.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })		
	@PatchMapping
	public ValuationUnitCategory updateValuationUnitCategoryByPartial(@RequestBody UnitCategoryAttributesDTO attrs) {
		return valuationUnitCategoryService.updateValuationUnitCategoryAttributes(attrs);
	}	
	@Operation(
			summary = "Create a valuation unit category by provide a new object", 
			description = "Create a valuation unit category object. The response is a list of most updated valuation unit category objects.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@PostMapping
	public List<ValuationUnitCategory> createValuationUnitCategory(@RequestBody UnitCategoryAttributesDTO valuationUnittoAdd) {
		valuationUnitCategoryService.addCategory(valuationUnittoAdd);
		return valuationUnitCategoryService.findAllCategories();
	}
	@Operation(
			summary = "Delete a valuation unit category by code", 
			description = "Delete a valuation unit category object by specifying its code.")
	@DeleteMapping("/{code}")
	public void deleteValuationUnitCategory(@PathVariable String code) {
		valuationUnitCategoryService.removeCategory(code);
	}
}