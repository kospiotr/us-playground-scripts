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
    -ui -client 0.0.0.0 \
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

NOMAD_SERVERS_NUMBER=2
NOMAD_DC_NAME=dc1
NOMAD_SERVER=true

cat >/etc/nomad.d/server.hcl <<EOL
data_dir = "/etc/nomad.d"

server {
  enabled          = true
  bootstrap_expect = ${NOMAD_SERVERS_NUMBER}
}
EOL

nohup nomad agent -config=/etc/nomad.d/server.hcl 2>&1 > /var/log/nomad.log &

echo "Installing Java RE 8"
sudo apt install -y software-properties-common dirmngr
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" |   sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" |   sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-set-default

echo "Downloading linkerd"
LINKERD_VERSION=1.4.0
curl -sSL https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}.tgz -o linkerd-${LINKERD_VERSION}.tgz
tar -xzf linkerd-${LINKERD_VERSION}.tgz
echo "Running linkerd"
cat >/tmp/linkerd-config.yaml <<EOL
admin:
  ip: 0.0.0.0
  port: 9990

# The filesystem namer (io.l5d.fs) watches the disco directory for changes.
# Each file in this directory represents a concrete name and contains a list
# of hostname/port pairs.
namers:
- kind: io.l5d.fs
  rootDir: /tmp/linkerd-1.4.0/disco

routers:
- protocol: http
  identifier:
    kind: io.l5d.path
    segments: 3
    consume: true
  dstPrefix: /api/svc1/prod1
  # /#/io.l5d.fs/prod1 - last segment of this URI has to match file name in ../disco directory
  dtab: |
    /api/svc1/prod1 => /#/io.l5d.fs/prod1;
  servers:
  - ip: 0.0.0.0
    port: 4140
EOL
cat >/tmp/linkerd-${LINKERD_VERSION}/disco/prod1 <<EOL
trade-webservice 8000
EOL

nohup ./linkerd-${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}-exec /tmp/linkerd-config.yaml  2>&1 > /var/log/consul.log &
