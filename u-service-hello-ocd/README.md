## Deploy

```
export BRANCH=master
export ENVIRONMENT=dev
wget "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/job.nomad" && nomad job run job.nomad
```
