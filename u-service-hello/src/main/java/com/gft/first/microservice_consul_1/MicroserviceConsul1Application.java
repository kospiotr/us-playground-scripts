package com.gft.first.microservice_consul_1;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Configuration
@EnableAutoConfiguration
@EnableDiscoveryClient
@RestController
public class MicroserviceConsul1Application {

	@RequestMapping("/")
	public String home() {
		return "Hello World";
	}

	@GetMapping("/my-health-check")
	public ResponseEntity<String> myCustomCheck() {
		String message = "Testing my healh check function";
		return new ResponseEntity<>(message, HttpStatus.OK);
	}

	public static void main(String[] args) {
		SpringApplication.run(MicroserviceConsul1Application.class, args);
	}
}
