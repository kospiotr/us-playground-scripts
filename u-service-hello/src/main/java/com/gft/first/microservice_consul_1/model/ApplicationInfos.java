package com.gft.first.microservice_consul_1.model;

import java.net.InetAddress;

public class ApplicationInfos {

    private String name;
    private InetAddress ip;
    private String hostname;
    private String local_server_port;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public InetAddress getIp() {
        return ip;
    }

    public void setIp(InetAddress ip) {
        this.ip = ip;
    }

    public String getHostname() {
        return hostname;
    }

    public void setHostname(String hostname) {
        this.hostname = hostname;
    }

    public String getLocal_server_port() {
        return local_server_port;
    }

    public void setLocal_server_port(String local_server_port) {
        this.local_server_port = local_server_port;
    }
}
