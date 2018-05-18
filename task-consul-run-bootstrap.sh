#!/bin/bash

echo "Running Consul in bootstrap and server mode"
nohup consul agent -server \
    -bootstrap-expect=1 -ui -client 0.0.0.0 \
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

echo "Consul is running"
