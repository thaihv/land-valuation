package com.jdvn.devtech.datamodel.controller;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import com.jdvn.devtech.datamodel.exception.BizErrorCode;
import com.jdvn.devtech.datamodel.exception.RequestPageable;
import com.jdvn.devtech.datamodel.exception.Response;
import com.jdvn.devtech.datamodel.exception.ResponseBuilder;
import com.jdvn.devtech.datamodel.exception.ResponseError;
import com.jdvn.devtech.datamodel.exception.ResponsePageable;
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
	public Response<ResponsePageable<ValuationUnitCategory>> getValuationUnitCategories(@RequestParam(defaultValue = "empty") String code, @RequestParam(defaultValue = "empty") String name, RequestPageable pageable) {
		if (!code.equals("empty")) {
			Optional<ValuationUnitCategory> vu= valuationUnitCategoryService.findByCategoryCode(code);
			if (vu.isPresent()) {
				ResponsePageable<ValuationUnitCategory> responseVo = new ResponsePageable<>(1, List.of(vu.get()), pageable);
				return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().addData(responseVo).build();
			}
			else {
				return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().fail().error(new ResponseError(BizErrorCode.E0002.getValue(),
								BizErrorCode.E0002.getDescription(), "The valuation unit category object has not been found!")).build();
			}
		}
		if (!name.equals("empty")) {
			Page<ValuationUnitCategory> page = valuationUnitCategoryService.findByCategoryName(name, pageable);
			if (page.getNumberOfElements() > 0) {
				ResponsePageable<ValuationUnitCategory> responseVo = new ResponsePageable<>(page.getTotalElements(), page.toList(), pageable);
				return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().addData(responseVo).build(); 
			}
			else {
				return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().fail().error(new ResponseError(BizErrorCode.E0002.getValue(),
						BizErrorCode.E0002.getDescription(), "The valuation unit category object has not been found!")).build();
			}

		}
		Page<ValuationUnitCategory> page = valuationUnitCategoryService.findAllCategories(pageable);
		if (page.getNumberOfElements() > 0) {
			ResponsePageable<ValuationUnitCategory> responseVo = new ResponsePageable<>(page.getTotalElements(), page.toList(), pageable);
			return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().addData(responseVo).build(); 
		}
		else {
			return new ResponseBuilder<ResponsePageable<ValuationUnitCategory>>().fail().error(new ResponseError(BizErrorCode.E0002.getValue(),
					BizErrorCode.E0002.getDescription(), "There is no valuation unit category objects have been found!")).build();			
		}

	}
	@Operation(
			summary = "Update a valuation unit category by provide fully object information. If the object is not existing then creating new one", 
			description = "Update a valuation unit category object by specifying its code and attribute. The response is a updated valuation unit category object.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })		
	@PutMapping
	public Response<ValuationUnitCategory> updateValuationUnitCategoryByWholeObject(@RequestBody UnitCategoryAttributesDTO attrs) {
		ValuationUnitCategory vu = valuationUnitCategoryService.updateOrSaveValuationUnitCategoryAttributes(attrs);
		return new ResponseBuilder<ValuationUnitCategory>().addData(vu).build(); 
	}
	
	@Operation(
			summary = "Update a valuation unit category by provide code and attributes", 
			description = "Update a valuation unit category object by specifying its code and few attributes. The response is a updated valuation unit category object.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "501", content = { @Content(schema = @Schema()) }) })		
	@PatchMapping
	public ResponseEntity<ValuationUnitCategory> updateValuationUnitCategoryByPartial(@RequestBody UnitCategoryAttributesDTO attrs) {
		ValuationUnitCategory vu = valuationUnitCategoryService.updateValuationUnitCategoryAttributes(attrs);
		if (vu != null) {
			return ResponseEntity.status(HttpStatus.OK).body(vu);
		}
		else {
			return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(vu);
		}
	}	
	@Operation(
			summary = "Create a valuation unit category by provide a new object", 
			description = "Create a valuation unit category object. The response is a list of most updated valuation unit category objects.")
	@ApiResponses({
			@ApiResponse(responseCode = "200", content = {@Content(schema = @Schema(implementation = ValuationUnitCategory.class), mediaType = "application/json") }),
			@ApiResponse(responseCode = "404", content = { @Content(schema = @Schema()) }),
			@ApiResponse(responseCode = "500", content = { @Content(schema = @Schema()) }) })
	@PostMapping
	public ResponseEntity<ValuationUnitCategory> createValuationUnitCategory(@RequestBody UnitCategoryAttributesDTO valuationUnittoAdd) {
		ValuationUnitCategory vu = valuationUnitCategoryService.addCategory(valuationUnittoAdd);
		return ResponseEntity.status(HttpStatus.OK).body(vu);
	}
	@Operation(
			summary = "Delete a valuation unit category by code", 
			description = "Delete a valuation unit category object by specifying its code.")
	@DeleteMapping("/{code}")
	public void deleteValuationUnitCategory(@PathVariable String code) {
		valuationUnitCategoryService.removeCategory(code);
	}
}