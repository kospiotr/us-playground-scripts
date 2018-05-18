#!/bin/bash

export BRANCH=$1

echo "Current branch is: ${BRANCH}"

echo "Installing dependencies - will be Ansible/Chef/Pupet responsibility for box configuration"
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-install.sh?nocache") > /var/log/task-consul-install.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-install.sh?nocache") > /var/log/task-nomad-install.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-java-install.sh?nocache") > /var/log/task-linkerd-install.log

echo "Running services - will be startup scripts responsibility"
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-run-bootstrap.sh?nocache") > /var/log/task-consul-run.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-run.sh?nocache") > /var/log/task-nomad-run.log
