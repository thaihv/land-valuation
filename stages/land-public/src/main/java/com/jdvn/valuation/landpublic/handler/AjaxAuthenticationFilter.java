package com.jdvn.valuation.landpublic.handler;

import java.io.IOException;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



public class AjaxAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
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
                if (info.size() == 2) {
                    logger.debug(info.get(0) + " : " + info.get(1));
                    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(info.get(0), info.get(1));
                    return getAuthenticationManager().authenticate(token);                     	
                }
                else {
                	throw new IllegalArgumentException("Authentication info may not for basic http!");
                }
            }
        }
        else {
        	throw new IllegalArgumentException("No authentication information has been found!");
        }
		return null;		
    }
	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
	        Authentication authResult) throws IOException, ServletException {
	    SecurityContextHolder.getContext().setAuthentication(authResult);
	    logger.debug("Authenticated successfully!...");
	    chain.doFilter(request, response);
	}
	@Override
	protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
	        AuthenticationException failed) throws IOException, ServletException {
	    logger.debug("Failed authentication while attempting to access ");
	    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authentication Failed");
	}
}