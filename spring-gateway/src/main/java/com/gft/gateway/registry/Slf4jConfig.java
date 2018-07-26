package com.gft.gateway.registry;

import io.micrometer.core.instrument.dropwizard.DropwizardConfig;

public interface Slf4jConfig extends DropwizardConfig {
    Slf4jConfig DEFAULT = k -> null;

    @Override
    default String prefix() {
        return "slf4j";
    }

    default String domain() {
        return "metrics";
    }

    default Integer period() {
        String v = this.get(this.prefix() + ".period");
        return v == null ? 0 :Integer.getInteger(v);
    }
}