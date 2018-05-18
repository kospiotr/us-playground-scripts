## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```
