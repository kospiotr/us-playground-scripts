## Deploy - Ansible job

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}
export LINKERD_VERSION=1.4.0
echo "Installing APP"
wget https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}.tgz /tmp/linkerd-${LINKERD_VERSION}.tgz
tar -xzf ./linkerd-${LINKERD_VERSION}.tgz -C ./

echo "Running APP"
wget "${REPO}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```
