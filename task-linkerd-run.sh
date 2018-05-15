#!/bin/bash

nohup ./linkerd-${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}-exec /tmp/linkerd-config.yaml  2>&1 > /var/log/consul.log &
