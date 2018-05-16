#!/bin/bash

echo "Running Consul in server mode"
nohup consul agent \
    -data-dir=/tmp/consul \
    -enable-script-checks=true -config-dir=/etc/consul.d \
    -retry-join=pk-api-orchestrator-1 2>&1 > /var/log/consul.log &

echo "Consul is running"
