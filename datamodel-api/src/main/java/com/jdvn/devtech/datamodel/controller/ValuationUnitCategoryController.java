package com.jdvn.devtech.datamodel.controller;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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

import com.jdvn.devtech.datamodel.repository.ValuationUnitCategoryRepository;
import com.jdvn.devtech.datamodel.schema.valuation.ValuationUnitCategory;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/vo_categories/v1")
@Tag(name = "Valuation Unit Categories", description = "Valuation Technical Object Categoty Management APIs")
public class ValuationUnitCategoryController {

	@Autowired
	private ValuationUnitCategoryRepository valuationUnitCategoryRepository;
	
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
	public Iterable<ValuationUnitCategory> getAllValuationUnitCategories() {
		return valuationUnitCategoryRepository.findAll();
	}
	@Operation(
			summary = "Retrieve a valuation unit by id", 
			description = "Get a valuation unit category object by specifying its id. The response is a valuation unit category object with id, name, description and status and metadata.", 
			tags = {"Category Objects", "Get" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@GetMapping("/find/{id}")
	public Optional<ValuationUnitCategory> findValuationUnitCategoryById(@PathVariable Long id) {
		return valuationUnitCategoryRepository.findById(id);
	}
	@Operation(
			summary = "Retrieve a valuation unit by name", 
			description = "Get a valuation unit category object by specifying its name and pageable from/to. The response is a valuation unit category object with id, name, description and status and metadata.", 
			tags = {"Valuation Objects", "Get" })
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })	
	@GetMapping("/findbyname/{name}")
	public List<ValuationUnitCategory> findValuationUnitCategoryByName(@PathVariable String name, @RequestParam int from, @RequestParam int to) {
		if (to > from) {
			Pageable pageable = PageRequest.of(from, to, Sort.by("name").descending());
			return valuationUnitCategoryRepository.findAllByName(name, pageable);			
		}
		else {
			Pageable pageable = PageRequest.of(0, 1, Sort.by("name").descending());
			return valuationUnitCategoryRepository.findAllByName(name, pageable);			
		}

	}
	@PostMapping("/update")
	public ValuationUnitCategory updateValuationUnitCategory(@RequestBody ValuationUnitCategory valuationUnitCategory) {
		return valuationUnitCategoryRepository.save(valuationUnitCategory);
	}

	@PostMapping("/create")
	public Iterable<ValuationUnitCategory> createValuationUnitCategory(@RequestBody ValuationUnitCategory valuationUnitCategory) {
		valuationUnitCategoryRepository.save(valuationUnitCategory);
		return valuationUnitCategoryRepository.findAll();
	}

	@DeleteMapping("/delete/{id}")
	public void deleteValuationUnitCategory(@PathVariable Long id) {
		valuationUnitCategoryRepository.deleteById(id);
	}
}