# us-playground-scripts
## Set-up

There should be only one bootstrap Consul instance so we need 1 bootstrap VM and one or more server instances. In order to not make each other to create and join the same cluster we will develop in isolated networks (VPCs). 

1. Set up private VPC
2. Add firewall rule that enables following ports: tcp:8500; tcp:9990; tcp:4646; tcp:4140
3. Create 2 templates that uses your VPC and add network tag with defined firewall rule:

Running for bootstrap VM:

```
export BRANCH=master
export REPO=raw.githubusercontent.com/kospiotr/us-playground-scripts
sudo su -c "bash <(wget -qO- "https://${REPO}/${BRANCH}/startup-bootstrap.sh?nocache") $BRANCH > /var/log/startup.log" root
```

Running for server VM:

```
export BRANCH=master
export REPO=raw.githubusercontent.com/kospiotr/us-playground-scripts
sudo su -c "bash <(wget -qO- "https://${REPO}/${BRANCH}/startup-instance.sh?nocache") $BRANCH > /var/log/startup.log" root
```

## Demo

### [x] Infrastructure

Boxes, Network, Firewall, Ports, Internal / External IPs

### [x] Architecture

Load Balancer -> Api G/W -> Service Discovery -> Micro Services

### Load balancer

Out of the scope

### [x] Consul

Service Discovery and dependency for Nomad, API G/W

* Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-install.sh
* Run bootstrap: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-bootstrap.sh
* Run instance: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-instance.sh
* Dashboard: http://35.234.127.135:8500/ui
* Sample CLI: `consul members`

### [x] Nomad

Scheduler for services

* Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-install.sh
* Run: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-run.sh
* Dashboard: http://35.234.127.135:4646/ui
* Sample CLI: `nomad server members`
* Clean dead jobs: `curl -X PUT http://35.234.127.135:4646/v1/system/gc`

### [] Api Gateway

#### [x] Linkerd

* Source code: https://github.com/kospiotr/us-playground-scripts/tree/master/linkerd-ocd
* Deploy:
```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts

wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```

#### Spring Gateway

* Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/job.nomad?nocache" -O u-service-hello-ocd.job.nomad && nomad job run u-service-hello-ocd.job.nomad
```

Dashboard: http://35.234.75.13:9990/?router=http

### [] Micro Services

* Sample App walkthrough (#TODO source code here)
* Rest Endpoints (#TODO list of the endpoint)
  * Service info / ID
  * Healthcheck
  * Delay
* Registration in Service Discovery

Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O u-service-hello-ocd.job.nomad && nomad job run u-service-hello-ocd.job.nomad
```

### Scale

