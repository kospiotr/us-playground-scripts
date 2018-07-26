package com.gft.gateway.registry;

import com.codahale.metrics.MetricRegistry;
import com.codahale.metrics.Slf4jReporter;
import io.micrometer.core.instrument.Clock;
import io.micrometer.core.instrument.dropwizard.DropwizardMeterRegistry;
import io.micrometer.core.instrument.util.HierarchicalNameMapper;

import java.util.concurrent.TimeUnit;

public class Slf4jMeterRegistry extends DropwizardMeterRegistry {
    private final Slf4jReporter reporter;

    public Slf4jMeterRegistry(Slf4jConfig config, Clock clock) {
        this(config, clock, HierarchicalNameMapper.DEFAULT);
    }

    public Slf4jMeterRegistry(Slf4jConfig config, Clock clock, HierarchicalNameMapper nameMapper) {
        this(config, clock, nameMapper, new MetricRegistry());
    }

    public Slf4jMeterRegistry(Slf4jConfig config, Clock clock, HierarchicalNameMapper nameMapper, MetricRegistry metricRegistry) {
        this(config, clock, nameMapper, metricRegistry, defaultJmxReporter(config, metricRegistry));
    }

    public Slf4jMeterRegistry(Slf4jConfig config, Clock clock, HierarchicalNameMapper nameMapper, MetricRegistry metricRegistry,
                              Slf4jReporter jmxReporter) {
        super(config, metricRegistry, nameMapper, clock);
        this.reporter = jmxReporter;
        this.reporter.start(20, TimeUnit.SECONDS);
    }

    private static Slf4jReporter defaultJmxReporter(Slf4jConfig config, MetricRegistry metricRegistry) {
        return Slf4jReporter.forRegistry(metricRegistry)
                .convertRatesTo(TimeUnit.SECONDS)
                .convertDurationsTo(TimeUnit.MILLISECONDS)
                .build();
    }

    public void stop() {
        this.reporter.stop();
    }

    public void start() {
        this.reporter.start(20, TimeUnit.SECONDS);
    }

    @Override
    public void close() {
        stop();
        super.close();
    }

    @Override
    protected Double nullGaugeValue() {
        return Double.NaN;
    }
}