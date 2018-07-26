package com.gft.gateway.registry;

import io.micrometer.core.instrument.Clock;
import org.springframework.boot.actuate.autoconfigure.metrics.CompositeMeterRegistryAutoConfiguration;
import org.springframework.boot.actuate.autoconfigure.metrics.MetricsAutoConfiguration;
import org.springframework.boot.actuate.autoconfigure.metrics.export.simple.SimpleMetricsExportAutoConfiguration;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

@Configuration
@AutoConfigureBefore({CompositeMeterRegistryAutoConfiguration.class,
        SimpleMetricsExportAutoConfiguration.class})
@AutoConfigureAfter(MetricsAutoConfiguration.class)
@ConditionalOnClass(Slf4jMeterRegistry.class)
@ConditionalOnProperty(prefix = "management.metrics.export.slf4j", name = "enabled", havingValue = "true", matchIfMissing = true)
@EnableConfigurationProperties(Slf4jProperties.class)
public class Slf4jMetricsExportAutoConfiguration {

    @Bean
    @ConditionalOnMissingBean
    public Slf4jConfig slf4jConfig(Slf4jProperties datadogProperties) {
        return new Slf4jPropertiesConfigAdapter(datadogProperties);
    }

    @Bean
    @ConditionalOnMissingBean
    public Slf4jMeterRegistry slf4jMeterRegistry(Slf4jConfig slf4jConfig,
                                                 Clock clock) {
        return new Slf4jMeterRegistry(slf4jConfig, clock);
    }

}
