## Deploy - Ansible job

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts

echo "Installing APP"
wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad"

echo "Running APP"
nomad job run linkerd.job.nomad
```
