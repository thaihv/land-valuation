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

import com.jdvn.valuation.landpublic.exception.BizErrorCode;
import com.jdvn.valuation.landpublic.exception.Response;
import com.jdvn.valuation.landpublic.exception.ResponseBuilder;
import com.jdvn.valuation.landpublic.exception.ResponseError;

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
    public Response<String> getStartedWithPost(@RequestBody String info) {
		if (info.equals("Hello")) {
			return new ResponseBuilder<String>().addData(info).build(); 
		}
		else {
			return new ResponseBuilder<String>().fail().error(new ResponseError(BizErrorCode.E0003.getValue(),
					BizErrorCode.E0003.getDescription(), "Message must be Hello as expected!")).build();			
		}
    }
}
