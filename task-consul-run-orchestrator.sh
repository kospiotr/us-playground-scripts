#!/bin/bash

echo "Running Consul in bootstrap and server mode"
nohup consul agent -server \
    -bootstrap-expect=2 -ui -client 0.0.0.0 \
    -data-dir=/tmp/consul \
    -enable-script-checks=true -config-dir=/etc/consul.d \
    -retry-join=pk-api-orchestrator-1 2>&1 > /var/log/consul.log &

echo "Consul is running"
