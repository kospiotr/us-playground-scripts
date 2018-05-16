#!/bin/bash

export BRANCH=$1

echo "Current branch is: ${BRANCH}"

bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-install.sh?nocache") > /var/log/task-consul-install.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-install.sh?nocache") > /var/log/task-nomad-install.log

bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-consul-run-client.sh?nocache") > /var/log/task-consul-run.log
bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/task-nomad-run-client.sh?nocache") > /var/log/task-nomad-run.log
