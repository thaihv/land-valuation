package com.egis.devtech.book;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class Egis0ServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(Egis0ServiceApplication.class, args);
		System.out.println("egis service started....!");
	}

}
