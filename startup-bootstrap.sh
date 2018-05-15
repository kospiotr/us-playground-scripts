#!/bin/bash

export BRANCH=$1

echo "Current branch is: ${BRANCH}"

echo "Installing CONSUL"
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-consul-install.sh?nocache") > /var/log/task-consul-install.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-nomad-install.sh?nocache") > /var/log/task-nomad-install.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-linkerd-install.sh?nocache") > /var/log/task-linkerd-install.log

#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-consul-run-server.sh?nocache") > /var/log/task-consul-run.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-nomad-run.sh?nocache") > /var/log/task-nomad-run.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-linkerd-run.sh?nocache") > /var/log/task-linkerd-run.log
