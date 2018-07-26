/*
 * Copyright 2012-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.gft.gateway.registry;

import org.springframework.boot.actuate.autoconfigure.metrics.export.properties.StepRegistryPropertiesConfigAdapter;

class Slf4jPropertiesConfigAdapter extends
        StepRegistryPropertiesConfigAdapter<Slf4jProperties> implements Slf4jConfig {

    Slf4jPropertiesConfigAdapter(Slf4jProperties properties) {
        super(properties);
    }

    @Override
    public Integer period() {
        return get(Slf4jProperties::getPeriod, Slf4jConfig.super::period);
    }
}
