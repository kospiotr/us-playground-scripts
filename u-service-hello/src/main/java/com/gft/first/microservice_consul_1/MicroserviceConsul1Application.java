package com.gft.first.microservice_consul_1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.net.InetAddress;
import java.net.UnknownHostException;

@Configuration
@EnableAutoConfiguration
@RestController
public class MicroserviceConsul1Application {

    private static final Logger LOGGER = LoggerFactory.getLogger(com.gft.first.microservice_consul_1.MicroserviceConsul1Application.class);

    @Value("${spring.application.name}")
    private String name;

    @Autowired
    private Environment environment;


    @RequestMapping("/")
    public String home() {
        return "Hello World MicroserviceConsul1Application";
    }

    @GetMapping("/my-health-check")
    public ResponseEntity<String> myCustomCheck() {
        String message = "Testing my healh check function";
        return new ResponseEntity<>(message, HttpStatus.OK);
    }

    @RequestMapping(value = "/api/inspect")
    public String apiInspect(@RequestParam(value = "delay", required = false) Integer delay) {

        InetAddress ip = null;
        String hostname = null;
        StringBuffer info =  new StringBuffer();

        try {
            if(delay != null){
                LOGGER.info("Sleep for : " +  delay + "ms");
                info.append("Your app was call with delay<b> " + delay + "ms</b></br>");

                Thread.sleep( delay );
            }

            ip = InetAddress.getLocalHost();
            hostname = ip.getHostName();

            LOGGER.info("Application name  : " +  name);
            LOGGER.info("Your current IP address : " + ip);
            LOGGER.info("Your current Hostname : " + hostname);
            LOGGER.info("Your current Local server port : " +  environment.getProperty("local.server.port"));

        } catch (InterruptedException e) {
            LOGGER.error("Logger InterruptedException " + e);
        } catch (UnknownHostException e) {
            LOGGER.error("Logger UnknownHostException " + e);
        }

        return info + "Application name  : <b>" +  name +
                "</b><br/>Your current IP address : <b>" + ip +
                "</b><br/> Your current Hostname : <b>" + hostname +
                "</b><br/>Your current Local server port  : <b>" +  environment.getProperty("local.server.port") + "</b>";
    }

    public static void main(String[] args) {
        SpringApplication.run(com.gft.first.microservice_consul_1.MicroserviceConsul1Application.class, args);
    }
}