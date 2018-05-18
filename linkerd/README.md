## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
wget "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```
