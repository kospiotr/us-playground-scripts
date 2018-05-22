#!/bin/bash

export BRANCH=$1

echo "Current branch is: ${BRANCH}"

echo "Installing dependencies - will be Ansible/Chef/Pupet responsibility for box configuration"
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-install.sh?$(uuidgen)") > /var/log/task-consul-install.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-install.sh?$(uuidgen)") > /var/log/task-nomad-install.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-java-install.sh?$(uuidgen)") > /var/log/task-java-install.log

echo "Running services - will be startup scripts responsibility"
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-run-instance.sh?$(uuidgen)") > /var/log/task-consul-run.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-run.sh?$(uuidgen)") > /var/log/task-nomad-run.log
