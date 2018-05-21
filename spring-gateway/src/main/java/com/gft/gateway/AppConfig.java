package com.gft.gateway;

import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.cloud.gateway.discovery.DiscoveryClientRouteDefinitionLocator;
import org.springframework.cloud.gateway.discovery.DiscoveryLocatorProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import static org.springframework.cloud.gateway.discovery.GatewayDiscoveryClientAutoConfiguration.initFilters;
import static org.springframework.cloud.gateway.discovery.GatewayDiscoveryClientAutoConfiguration.initPredicates;

/**
 * Created by e-mznt on 16.05.2018.
 */
@Configuration
@EnableDiscoveryClient
@RefreshScope
public class AppConfig {

    @Bean
    public DiscoveryClientRouteDefinitionLocator
    discoveryClientRouteLocator(DiscoveryClient discoveryClient,DiscoveryLocatorProperties properties) {
        return new DiscoveryClientRouteDefinitionLocator(discoveryClient,properties);
    }

    @Bean
    public DiscoveryLocatorProperties discoveryLocatorProperties() {
        DiscoveryLocatorProperties properties = new DiscoveryLocatorProperties();
        properties.setPredicates(initPredicates());
        properties.setFilters(initFilters());
        return properties;
    }
}
