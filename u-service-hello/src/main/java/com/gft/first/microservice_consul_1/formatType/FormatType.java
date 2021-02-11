package com.gft.first.microservice_consul_1.formatType;

import com.gft.first.microservice_consul_1.model.ApplicationInfos;

public interface FormatType {

    public String getHostInfo(ApplicationInfos applicationInfos, StringBuffer infoDelay);
}
