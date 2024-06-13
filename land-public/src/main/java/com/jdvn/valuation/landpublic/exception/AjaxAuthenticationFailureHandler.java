package com.jdvn.valuation.landpublic.exception;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// For authentication
public class AjaxAuthenticationFailureHandler implements AuthenticationEntryPoint {

	private ObjectMapper objectMapper = new ObjectMapper();
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        String errorMessage = "Invalid username or password";

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);


        if (exception instanceof BadCredentialsException) {
            errorMessage = "Invalid username or password";
        } 
        else if (exception instanceof InsufficientAuthenticationException) {
            errorMessage = "Your credentials are not sufficiently trusted";
        } 
        objectMapper.writeValue(response.getWriter(), errorMessage);
    }

}