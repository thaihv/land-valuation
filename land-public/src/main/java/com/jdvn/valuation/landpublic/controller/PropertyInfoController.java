package com.jdvn.valuation.landpublic.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jdvn.valuation.landpublic.exception.Response;
import com.jdvn.valuation.landpublic.exception.ResponseBuilder;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api")
@SecurityRequirement(name = "basicAuth")
@Tag(name = "Valuation Unit Information", description = "Valuation Unit Information Management APIs")
public class PropertyInfoController {

    @GetMapping("/parcel/basic")
	@Operation(
			summary = "Retrieve basic info of a parcel", 
			description = "Get all basic info. The response is a collection of values.",
//			security = @SecurityRequirement(name = "basicAuth"),
			tags = {"parcel", "get" })
    public Response<Map<String, String>>  getParcelBasicInfo(Model model) {
        HashMap<String, String> info = new HashMap<>();
        info.put("key", "value");
        info.put("foo", "bar");
        info.put("aa", "bb");
        return new ResponseBuilder<Map<String, String>>().addData(info).build();
    }
    @PostMapping("/parcel/propertyToAdd")
    public Response<Map<String, String>> createInfo(@RequestBody String parcel_info) {
    	HashMap<String, String> info = new HashMap<>();
    	System.out.println(parcel_info.toString());
    	info.put("data", parcel_info);
    	info.put("status", "Added!");
        return new ResponseBuilder<Map<String, String>>().addData(info).build();
    }
}
