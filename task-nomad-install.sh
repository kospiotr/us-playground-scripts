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

sudo mkdir -p /var/nomad
sudo chmod a+w /var/nomad

cat >/etc/nomad.d/server.hcl <<EOL
data_dir = "/var/nomad"
server {
  enabled          = true
  bootstrap_expect = 2
}
client {
  enabled = true
}
EOL

echo "Nomad installed"
