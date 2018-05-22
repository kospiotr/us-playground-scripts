## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-app1-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O u-service-app1-ocd.job.nomad && nomad job run u-service-app1-ocd.job.nomad
```
