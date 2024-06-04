package com.jdvn.valuation.landpublic.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/greeting/v1")
@Tag(name = "Greetings", description = "To say hello to the world")
public class HelloController {

    @GetMapping("/sayHi/{message}")
    public String getStarted(@PathVariable String message) {
        return "Hello, World " + message;
    }
    @PostMapping("/sayHi")
    public @ResponseBody String getStartedWithPost(@RequestBody String info) {
        return "Hello, World" + info;
    }
}
