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

import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api")
@Tag(name = "Valuation Unit Information", description = "Valuation Unit Information Management APIs")
public class PropertyInfoController {

    @GetMapping("/parcel/basic")
    public Map<String, String>  getParcelBasicInfo(Model model) {
        HashMap<String, String> info = new HashMap<>();
        info.put("key", "value");
        info.put("foo", "bar");
        info.put("aa", "bb");
        return info;
    }
    @PostMapping("/parcel/propertyToAdd")
    public String createInfo(@RequestBody String parcel_info) {
    	System.out.println(parcel_info.toString());
        return "Added! " + parcel_info;
    }
}
