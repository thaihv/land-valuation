package com.jdvn.valuation.landpublic.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jdvn.valuation.landpublic.except.BizErrorCode;
import com.jdvn.valuation.landpublic.except.BizException;
import com.jdvn.valuation.landpublic.except.Response;
import com.jdvn.valuation.landpublic.except.ResponseBuilder;

import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/greeting/v1")
@Tag(name = "Greetings", description = "To say hello to the world")
public class HelloController {

    @GetMapping("/sayHi/{message}")
    public Response<Map<String, String>> getStarted(@PathVariable String message) {        
    	HashMap<String, String> info = new HashMap<>();
    	info.put("Your info", message);
    	info.put("sayHi", "Hello, World");
        return new ResponseBuilder<Map<String, String>>().addData(info).build();
    }
    @PostMapping("/sayHi")
    public Response<String> getStartedWithPost(@RequestBody String info) throws BizException {
		if (info.equals("Hello")) {
			return new ResponseBuilder<String>().addData(info).build(); 
		}
		else {
			throw new BizException(BizErrorCode.E0003, "RequestBody must have a value such as Hello!");			
		}
    }
}
