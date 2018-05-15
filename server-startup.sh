#!/bin/bash

echo "Installing dependencies ..."
sudo apt-get update
sudo apt-get install -y unzip curl jq dnsutils
echo "Determining Consul version to install ..."
CHECKPOINT_URL="https://checkpoint-api.hashicorp.com/v1/check"
if [ -z "$CONSUL_DEMO_VERSION" ]; then
    CONSUL_DEMO_VERSION=$(curl -s "${CHECKPOINT_URL}"/consul | jq .current_version | tr -d '"')
fi
echo "Fetching Consul version ${CONSUL_DEMO_VERSION} ..."
cd /tmp/
curl -s https://releases.hashicorp.com/consul/${CONSUL_DEMO_VERSION}/consul_${CONSUL_DEMO_VERSION}_linux_amd64.zip -o consul.zip
echo "Installing Consul version ${CONSUL_DEMO_VERSION} ..."
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul
sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d

echo "Running Consul"
nohup consul agent -server -bootstrap-expect=2 \
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
