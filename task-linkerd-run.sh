#!/bin/bash

echo "Run Linkerd"
LINKERD_VERSION=1.4.0
nohup /tmp/linkerd-${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}-exec /etc/linkerd.d/config.yaml  2>&1 > /var/log/consul.log &
echo "Linkerd is running"
