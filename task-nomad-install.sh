#!/bin/bash

echo "Installing Nomad dependencies ..."
sudo apt-get update
sudo apt-get install -y unzip curl jq dnsutils

# Nomad Download & Start
NOMAD_VERSION=0.8.3

echo "Fetching Nomad..."
cd /tmp/
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip

echo "Installing Nomad..."
unzip nomad.zip
sudo install nomad /usr/bin/nomad

sudo mkdir -p /etc/nomad.d
sudo chmod a+w /etc/nomad.d

NOMAD_SERVERS_NUMBER=1
NOMAD_DC_NAME=dc1
NOMAD_SERVER=true

cat >/etc/nomad.d/server.hcl <<EOL
data_dir = "/etc/nomad.d"
server {
  enabled          = true
  bootstrap_expect = ${NOMAD_SERVERS_NUMBER}
}
consul {
  address = "127.0.0.1:8500"
}
EOL

cat >/etc/nomad.d/client.hcl <<EOL
datacenter = "${NOMAD_DC_NAME}"
data_dir   = "/etc/nomad.d"

client {
  enabled = true
}
EOL

echo "Nomad installed"
