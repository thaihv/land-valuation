package com.jdvn.devtech.datamodel.controller;
import java.util.List;
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
@RequestMapping("/v1/vucategories")
@Tag(name = "Valuation Unit Categories", description = "Valuation Technical Object Categoty Management APIs")
public class ValuationUnitCategoryController {

	@Autowired
	private ValuationUnitCategoryService valuationUnitCategoryService;
	
	@Operation(
			summary = "Retrieve all valuation unit category values", 
			description = "Get all valuation unit category objects. The response is a collection of valuation unit category objects.", 
			tags = {"Category Objects", "Get" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })	
	@GetMapping(path = "/list", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<ValuationUnitCategory> getAllValuationUnitCategories() {
		return valuationUnitCategoryService.findAllCategories();
	}
	@Operation(
			summary = "Retrieve a valuation unit category by code", 
			description = "Get a valuation unit category object by specifying its code. The response is a valuation unit category object with code, name, description and status and metadata.", 
			tags = {"Category Objects", "Get" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@GetMapping("/find/{code}")
	public Optional<ValuationUnitCategory> findValuationUnitCategoryById(@PathVariable String code) {
		return valuationUnitCategoryService.findByCategoryCode(code);
	}
	@Operation(
			summary = "Retrieve a valuation unit category by name", 
			description = "Get a valuation unit category object by specifying its name and pageable from/to. The response is a valuation unit category object with id, name, description and status and metadata.", 
			tags = {"Valuation Objects", "Get" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })	
	@GetMapping("/findbyname/{name}")
	public List<ValuationUnitCategory> findValuationUnitCategoryByName(@PathVariable String name, @RequestParam int from, @RequestParam int to) {
		return valuationUnitCategoryService.findByCategoryName(name, from, to);	
	}
	@Operation(
			summary = "Update a valuation unit category by code", 
			description = "Update a valuation unit category object by specifying its code and attribute. The response is a updated valuation unit category object.", 
			tags = {"Valuation Objects", "Update" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })		
	@PostMapping("/update")
	public ValuationUnitCategory updateValuationUnitCategory(@RequestBody UnitCategoryAttributesDTO attrs) {
		return valuationUnitCategoryService.updateValuationUnitCategoryAttributes(attrs);
	}

	@PostMapping("/create")
	public List<ValuationUnitCategory> createValuationUnitCategory(@RequestBody UnitCategoryAttributesDTO valuationUnittoAdd) {
		valuationUnitCategoryService.addCategory(valuationUnittoAdd);
		return valuationUnitCategoryService.findAllCategories();
	}

	@DeleteMapping("/delete/{code}")
	public void deleteValuationUnitCategory(@PathVariable String code) {
		valuationUnitCategoryService.removeCategory(code);
	}
}