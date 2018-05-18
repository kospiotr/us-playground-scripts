## Deploy - Ansible job

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
export LINKERD_VERSION=1.4.0
echo "Installing APP"
wget https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}.tgz /tmp/linkerd-${LINKERD_VERSION}.tgz
tar -xzf ./linkerd-${LINKERD_VERSION}.tgz -C ./

mv ./linkerd-${LINKERD_VERSION}/config/linkerd.yaml ./linkerd-${LINKERD_VERSION}/config/linkerd.yaml.old -f
wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/linkerd.yaml" -O ./linkerd-${LINKERD_VERSION}/config/linkerd.yaml
wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad"

echo "Running APP"
nomad job run linkerd.job.nomad
```
