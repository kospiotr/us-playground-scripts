## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-another-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O u-service-another-ocd.job.nomad && nomad job run u-service-another-ocd.job.nomad
```
