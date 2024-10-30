package com.egis.devtech.book.controller;

import java.util.HashMap;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/greeting/v1")
@Tag(name = "Greetings", description = "To say hello to the world")
public class HelloController {

    @GetMapping("/sayHi/{message}")
    public HashMap<String, String> getStarted(@PathVariable String message) {        
    	HashMap<String, String> info = new HashMap<>();
    	info.put("Your info", message);
    	info.put("sayHi", "Hello, World");
        return info;
    }
}
