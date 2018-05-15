#!/bin/bash

echo "Running Consul"
nohup consul agent -server \
    -data-dir=/tmp/consul \
    -enable-script-checks=true -config-dir=/etc/consul.d \
    -retry-join=pk-api-bootstrap \
    -retry-join=10.156.0.2 \
    -retry-join=10.156.0.3 \
    -retry-join=10.156.0.4 \
    -retry-join=10.156.0.5 \
    -retry-join=10.156.0.6 \
    -retry-join=10.156.0.7 \
    -retry-join=10.156.0.8 \
    -retry-join=10.156.0.9 \
    -retry-join=10.156.0.10 2>&1 > /var/log/consul.log &
