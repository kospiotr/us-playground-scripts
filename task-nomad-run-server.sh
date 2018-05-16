#!/bin/bash

echo "Running Nomad"
nohup nomad agent -config=/etc/nomad.d/server.hcl 2>&1 > /var/log/nomad.log &
echo "Nomad is running"
