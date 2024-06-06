package com.jdvn.valuation.landpublic.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;

@Configuration
@SecurityScheme(
    name = "basicAuth",
    type = SecuritySchemeType.HTTP,
    scheme = "basic"
)
public class OpenAPIConfig {

  @Bean
  OpenAPI myOpenAPI() {


    Contact contact = new Contact();
    contact.setEmail("jdvn@uitgis.com");
    contact.setName("JUNGDO UIT Vietnam");
    contact.setUrl("http://uitgis.com/viet/");

    License mitLicense = new License().name("No License").url("http://uitgis.com/viet/");

    Info info = new Info()
        .title("Property Valuation Information Public Management APIs")
        .version("1.0")
        .contact(contact)
        .description("This API exposes endpoints to public infomation of Valuation Information System.").termsOfService("http://uitgis.com/viet/")
        .license(mitLicense);

    return new OpenAPI().info(info);
  }
}