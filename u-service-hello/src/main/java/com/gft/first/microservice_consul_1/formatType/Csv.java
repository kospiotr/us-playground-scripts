package com.gft.first.microservice_consul_1.formatType;

import com.gft.first.microservice_consul_1.model.ApplicationInfos;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Csv implements FormatType {

    private static final Logger LOGGER = LoggerFactory.getLogger(Csv.class);

    @Override
    public String getHostInfo(ApplicationInfos applicationInfos, StringBuffer infoDelay) {
        LOGGER.info("Info Delay : " + infoDelay);
        LOGGER.info("Application name : " + applicationInfos.getName());
        LOGGER.info("Your current IP address : " + applicationInfos.getIp());
        LOGGER.info("Your current Hostname : " + applicationInfos.getHostname());
        LOGGER.info("Your current Local server port  : " + applicationInfos.getLocal_server_port());

        return " \"Application name\":\"" + applicationInfos.getName() +
                "\", \"Your current IP address\":\"" + applicationInfos.getIp() +
                "\",\"Your current Hostname\":\"" + applicationInfos.getHostname() +
                "\", \"Your current Local server port\":\"" + applicationInfos.getLocal_server_port()  + "\"";
    }
}
