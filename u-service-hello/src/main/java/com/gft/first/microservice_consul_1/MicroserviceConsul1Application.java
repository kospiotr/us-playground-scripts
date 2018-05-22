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
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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

    @RequestMapping(value = "/api/inspect", method= RequestMethod.GET )
    public String apiInspectCsv(HttpServletResponse response,
                                                  @RequestParam(value = "delay", required = false) Integer delay,
                                                  @RequestParam(value = "format", required = false) String format) throws IOException {

        if (format != null && format.equals("Fcsv")) {
            response.addHeader("Content-disposition", "attachment;filename=myfilename.csv");
            response.setContentType("txt/plain");
            response.getOutputStream().write(getHostInfo("csv", delay).getBytes());
            response.getOutputStream().flush();
        }

        return getHostInfo(format, delay);
    }

    private String getHostInfo(String format, Integer delay) {
        InetAddress ip = null;
        String hostname = null;
        StringBuffer info =  new StringBuffer();
    try{

        callThreadSleep(delay, info);

        ip = InetAddress.getLocalHost() ;
        hostname = ip.getHostName();

        } catch (UnknownHostException e) {
            LOGGER.error("Logger UnknownHostException " + e);
        } catch (InterruptedException e) {
              LOGGER.error("Logger InterruptedException " + e);
        }

        String returnedString = getStringOfParamethers(format, ip, hostname, info);
        if (returnedString != null) return returnedString;
        return "Please enter paramether format csv of html and delay = X ms";
    }

    private String getStringOfParamethers(String format, InetAddress ip, String hostname, StringBuffer info) {

        if (format != null && format.equals("html")) {
            return info + "Application name  : <b>" +  name +
                    "</b><br/>Your current IP address : <b>" + ip +
                    "</b><br/> Your current Hostname : <b>" + hostname +
                    "</b><br/>Your current Local server port  : <b>" +  environment.getProperty("local.server.port") + "</b>";

        }else if (format != null && format.equals("csv")) {
            return " \"Application name\":\"" +  name + "\", \"Your current IP address\":\"" + ip + "\",\"Your current Hostname\":\"" + hostname + "\", \"Your current Local server port\":\"" +  environment.getProperty("local.server.port")  +"\"";
        }
        return null;
    }

    private void callThreadSleep(Integer delay, StringBuffer info) throws InterruptedException {
        if(delay != null){
            LOGGER.info("Sleep for : " +  delay + "ms");
            info.append("Your app was call with delay<b> " + delay + "ms</b></br>");

            Thread.sleep( delay );
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(com.gft.first.microservice_consul_1.MicroserviceConsul1Application.class, args);
    }}