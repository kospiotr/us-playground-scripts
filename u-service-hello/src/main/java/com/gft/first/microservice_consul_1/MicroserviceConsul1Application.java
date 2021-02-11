package com.gft.first.microservice_consul_1;

import com.gft.first.microservice_consul_1.formatType.CompressionContext;
import com.gft.first.microservice_consul_1.formatType.Csv;
import com.gft.first.microservice_consul_1.formatType.Html;
import com.gft.first.microservice_consul_1.model.ApplicationInfos;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.net.InetAddress;
import java.net.UnknownHostException;

@RestController
@SpringBootApplication
public class MicroserviceConsul1Application {

    private static final Logger LOGGER = LoggerFactory.getLogger(com.gft.first.microservice_consul_1.MicroserviceConsul1Application.class);

    @Value("${spring.application.name}")
    private String name;

    @Autowired
    CompressionContext ctx;

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

    @RequestMapping(value = "/api/inspect", method = RequestMethod.GET)
    public String apiInspectCsv(HttpServletResponse response,
                                @RequestParam(value = "delay", required = false) Integer delay,
                                @RequestParam(value = "format", required = false) String format) {

        ApplicationInfos applicationInfos = new ApplicationInfos();
        StringBuffer info = new StringBuffer();

        callThreadSleep(delay, info);
        getHostInfo(format, applicationInfos);

        if (format != null && format.equals("csv")) {
            ctx.setFormatType(new Csv());
        }else{
            ctx.setFormatType(new Html());
        }

        return ctx.retriveInfos(applicationInfos, info);
    }

    private void getHostInfo(String format, ApplicationInfos applicationInfos) {

        try {
            applicationInfos.setIp(InetAddress.getLocalHost());
            applicationInfos.setHostname(InetAddress.getLocalHost().getHostName());
            applicationInfos.setName(name);
            applicationInfos.setLocal_server_port(environment.getProperty("local.server.port"));

        } catch (UnknownHostException e) {
            LOGGER.error("Logger UnknownHostException " + e);
        }
    }

    private void callThreadSleep(Integer delay, StringBuffer info) {
        if (delay != null) {

            try {
                Thread.sleep(delay);

                LOGGER.info("Sleep for : " + delay + "ms");
                info.append("Your app was call with delay<b> " + delay + "ms</b></br>");

            } catch (InterruptedException e) {
                LOGGER.error("Logger InterruptedException " + e);
            }
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(com.gft.first.microservice_consul_1.MicroserviceConsul1Application.class, args);
    }
}
