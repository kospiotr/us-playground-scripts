## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-app2-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O u-service-app2-ocd.job.nomad && nomad job run u-service-app2-ocd.job.nomad
```
