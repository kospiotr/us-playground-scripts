export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}
wget "${REPO}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
