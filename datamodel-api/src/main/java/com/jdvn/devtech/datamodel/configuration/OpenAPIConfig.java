package com.jdvn.devtech.datamodel.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;

@Configuration
public class OpenAPIConfig {

  @Bean
  public OpenAPI myOpenAPI() {


    Contact contact = new Contact();
    contact.setEmail("thaihv@uitgis.com");
    contact.setName("JungdoUIT Vietnam");
    contact.setUrl("http://uitgis.com/viet/");

    License mitLicense = new License().name("No License").url("http://uitgis.com/viet/");

    Info info = new Info()
        .title("Property Valuation Management APIs")
        .version("1.0")
        .contact(contact)
        .description("This API exposes endpoints to manage Valuation Information Model.").termsOfService("http://uitgis.com/viet/")
        .license(mitLicense);

    return new OpenAPI().info(info);
  }
}