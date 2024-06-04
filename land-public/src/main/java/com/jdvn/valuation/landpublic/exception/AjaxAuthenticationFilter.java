package com.jdvn.valuation.landpublic.exception;

import java.io.IOException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



public class AjaxAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    public AjaxAuthenticationFilter() {
        super(new AntPathRequestMatcher("/api/**"));
    }
    
	@Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.length() != 0 && authHeader.startsWith("Basic ")) {
            String based64 = authHeader.substring(6);
            if (based64 != null) {
                byte[] decodedBytes = Base64.getDecoder().decode(based64);
                String decoded = new String(decodedBytes);                
                List<String> info = Arrays.asList(decoded.split(":"));
                if (info.get(0).isEmpty() || info.get(0).isBlank()) {
                	throw new IllegalArgumentException("Invalid username or password");                    
                }
                UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(info.get(0), info.get(1));
                return getAuthenticationManager().authenticate(token);                
            }
        }
        else {
        	throw new IllegalArgumentException("Invalid username or password");
        }
		return null;		
    }
}