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
sudo su -c "bash <(wget -qO- "https://${REPO}/${BRANCH}/startup-bootstrap.sh?$(uuidgen)") $BRANCH > /var/log/startup.log" root
```

Running for server VM:

```
export BRANCH=master
export REPO=raw.githubusercontent.com/kospiotr/us-playground-scripts
sudo su -c "bash <(wget -qO- "https://${REPO}/${BRANCH}/startup-instance.sh?$(uuidgen)") $BRANCH > /var/log/startup.log" root
```

## Demo

### Architecture

Load Balancer -> Api G/W -> Service Discovery -> Micro Services

### Consul

Service Discovery and dependency for Nomad, API G/W

* Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-install.sh
* Run bootstrap: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-bootstrap.sh
* Run instance: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-instance.sh
* Dashboard: http://35.234.127.135:8500/ui
* Sample CLI: `consul members`

### Nomad

Scheduler for services

* Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-install.sh
* Run: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-run.sh
* Dashboard: http://35.234.127.135:4646/ui
* Sample CLI: `nomad server members`
* Clean dead jobs: `curl -X PUT http://35.234.127.135:4646/v1/system/gc`

<p align="center"><img src="https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/01-Initial%20setup.png"/></p>

### Micro Services

Code (https://github.com/kospiotr/us-playground-scripts/tree/master/u-service-hello)

#### Features

* Accepts application name as argument
* Automatic registration in Consul (Service Discovery) 

#### Rest Endpoints
* GET `/` - default entrypoint displaying Hello World
* GET `/my-health-check` - healthcheck for service discovery and or gateway
* GET `/api/inspect` - displaying app instance info
  * `delay` - [optional, query] sleep value in ms
  * `format` - [optional, query, default: html, values: html, csv] output format 
    
* Deploy 1 micro service:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-app1-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O u-service-app1-ocd.job.nomad && nomad job run u-service-app1-ocd.job.nomad
```

<p align="center"><img src="https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/02-First app.png"/></p>

### Api Gateway

#### Linkerd

* Source code: https://github.com/kospiotr/us-playground-scripts/tree/master/linkerd-ocd
* Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts

wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```

* Dashboard: http://35.234.127.135:9990/?router=http
* external_api_one app:
  * Root: http://35.234.127.135:4140/external_api_one/
  * HC: http://35.234.127.135:4140/external_api_one/my-health-check/
  * Inspect: http://35.234.127.135:4140/external_api_one/api/inspect

#### Spring Gateway

* Code: https://github.com/kospiotr/us-playground-scripts/tree/master/spring-gateway-ocd
* Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/spring-gateway-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O spring-gateway.job.nomad && nomad job run spring-gateway.job.nomad
```

* external_api_one app:
  * Root: http://35.234.127.135:4141/external_api_one/
  * HC: http://35.234.127.135:4141/external_api_one/my-health-check/
  * Inspect: http://35.234.127.135:4141/external_api_one/api/inspect


<p align="center"><img src="https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/03-API-GW.png"/></p>

### Routing

* Deploy 2 micro service:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-app2-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O u-service-app2-ocd.job.nomad && nomad job run u-service-app2-ocd.job.nomad
```

#### Linkerd
* external_api_two app:
  * Root: http://35.234.127.135:4140/external_api_two/
  * HC: http://35.234.127.135:4140/external_api_two/my-health-check/
  * Inspect: http://35.234.127.135:4140/external_api_two/api/inspect

#### Spring Gateway
* external_api_two app:
  * Root: http://35.234.127.135:4141/external_api_two/
  * HC: http://35.234.127.135:4141/external_api_two/my-health-check/
  * Inspect: http://35.234.127.135:4141/external_api_two/api/inspect

### Scale & Load Balancing

Will be using application_one on the Spring Gateway

* Hit Spring Gateway with load
  * JMeter instructions: https://github.com/kospiotr/us-playground-scripts/tree/master/api-gateway-LT
  * Enpoint: http://35.234.127.135:4141/external_api_one/api/inspect
  * Observe characteristics for 1 instance
* Scale app up to 5 instances
  * Edit: https://github.com/kospiotr/us-playground-scripts/edit/master/u-service-app1-ocd/dev/deploy.job.nomad
  * Deploy again:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-app1-ocd/${ENVIRONMENT}/deploy.job.nomad?$(uuidgen)" -O u-service-app1-ocd.job.nomad && nomad job run u-service-app1-ocd.job.nomad
```
  * Observe Load Balancing: http://35.234.127.135:4141/external_api_one/api/inspect
  * Hit Spring Gateway with load again
