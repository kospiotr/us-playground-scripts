#!/bin/bash

echo "Running Consul"
nohup consul agent \
    -data-dir=/tmp/consul \
    -enable-script-checks=true -config-dir=/etc/consul.d \
    -retry-join=10.156.0.1 \
    -retry-join=10.156.0.2 \
    -retry-join=10.156.0.3 \
    -retry-join=10.156.0.4 \
    -retry-join=10.156.0.5 \
    -retry-join=10.156.0.6 2>&1 > /var/log/consul.log &

echo "Consul is running"
