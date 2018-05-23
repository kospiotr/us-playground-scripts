package com.gft.first.microservice_consul_1.formatType;

import com.gft.first.microservice_consul_1.model.ApplicationInfos;
import org.springframework.stereotype.Component;

@Component
public class CompressionContext {

    private FormatType formatType;

    public void setFormatType(FormatType formatType) {
        this.formatType = formatType;
    }

    public String retriveInfos(ApplicationInfos ai, StringBuffer in){
       return formatType.getHostInfo(ai, in);
    }
}
