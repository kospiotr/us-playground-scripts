#!/bin/bash

echo "Installing dependencies ..."
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
