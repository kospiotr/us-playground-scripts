#!/bin/bash

echo "Installing Linkerd dependencies ..."
sudo apt-get update
sudo apt-get install -y unzip curl jq dnsutils

echo "Installing Java RE 8"
sudo apt install -y software-properties-common dirmngr
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" |   sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" |   sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-set-default

echo "Downloading Linkerd"
LINKERD_VERSION=1.4.0
curl -sSL https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}.tgz -o linkerd-${LINKERD_VERSION}.tgz
tar -xzf linkerd-${LINKERD_VERSION}.tgz
echo "Running linkerd"
cat >/tmp/linkerd-config.yaml <<EOL
admin:
  ip: 0.0.0.0
  port: 9990

namers:
- kind: io.l5d.consul
  includeTag: false
  useHealthCheck: false
  host: 0.0.0.0

routers:
- protocol: http
  identifier:
    kind: io.l5d.path
    segments: 3
    consume: true
  dstPrefix: /api/custom/prod
  dtab: |
    /api/custom/prod => /#/io.l5d.consul/dc1;
  servers:
  - ip: 0.0.0.0
    port: 4140
EOL
