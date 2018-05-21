## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/job.nomad?nocache" -O u-service-hello-ocd.job.nomad && nomad job run u-service-hello-ocd.job.nomad
```
