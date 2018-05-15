#!/bin/bash

export BRANCH=$1

echo "Current branch is: ${BRANCH}"

bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-consul-install.sh") > task-consul-install.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-nomad-install.sh") > task-nomad-install.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-linkerd-install.sh") > task-linkerd-install.log

#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-consul-run-server.sh") > task-consul-run.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-nomad-run.sh") > task-nomad-run.log
#bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}task-linkerd-run.sh") > task-linkerd-run.log
