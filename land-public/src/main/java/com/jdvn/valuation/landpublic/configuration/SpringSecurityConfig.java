package com.jdvn.valuation.landpublic.configuration;

import java.util.Arrays;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import com.jdvn.valuation.landpublic.exception.AjaxAccessDeniedHandler;
import com.jdvn.valuation.landpublic.exception.AjaxAuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig {

//	@Autowired
//	private AuthenticationConfiguration authenticationConfiguration;
//  @Bean
//  AjaxAuthenticationFilter ajaxAuthenticationFilter() throws Exception {
//      AjaxAuthenticationFilter ajaxAuthenticationFilter = new AjaxAuthenticationFilter();
//      ajaxAuthenticationFilter.setAuthenticationFailureHandler(ajaxAuthenticationFailureHandler());
//      ajaxAuthenticationFilter.setAuthenticationManager(authenticationManager(authenticationConfiguration));
//      return ajaxAuthenticationFilter;
//  } 	
	@Bean
	AccessDeniedHandler ajaxAccessDeniedHandler() {
		return new AjaxAccessDeniedHandler();
	}      	
	@Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }		
	@Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception { 
        http
        .csrf(csrf -> csrf.disable())
        		.authorizeHttpRequests(auth -> auth
                    .requestMatchers(HttpMethod.GET,"/greeting/**").permitAll()
                    .requestMatchers(HttpMethod.POST,"/greeting/**").permitAll()
                    .requestMatchers(HttpMethod.OPTIONS,"/**").permitAll()
                    .requestMatchers("/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                    .anyRequest().authenticated()
                )
                .sessionManagement(sess -> sess.sessionCreationPolicy(SessionCreationPolicy.NEVER))
                .httpBasic(Customizer.withDefaults());
                //.addFilterAfter(ajaxAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

		http.exceptionHandling(ex -> ex.authenticationEntryPoint(new AjaxAuthenticationFailureHandler()))
			.exceptionHandling(ex -> ex.accessDeniedHandler(ajaxAccessDeniedHandler()));
        return http.build();
	}
    @Bean
    CorsConfigurationSource corsConfigurationSource() {
    	CorsConfiguration configuration = new CorsConfiguration();
    	configuration.setAllowedOrigins(Arrays.asList("*"));
    	configuration.setAllowedMethods(Arrays.asList("GET","POST","PUT","HEAD","PATCH","OPTIONS"));
    	UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    	source.registerCorsConfiguration("/**", configuration);
    	return source;
    }
    
    @Bean
    PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
