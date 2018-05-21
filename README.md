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

### :white_check_mark: Infrastructure

Boxes, Network, Firewall, Ports, Internal / External IPs

### :white_check_mark: Architecture

Load Balancer -> Api G/W -> Service Discovery -> Micro Services

### :black_square_button: Load balancer

Out of the scope

### :white_check_mark: Consul

Service Discovery and dependency for Nomad, API G/W

* :white_check_mark: Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-install.sh
* :white_check_mark: Run bootstrap: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-bootstrap.sh
* :white_check_mark: Run instance: https://github.com/kospiotr/us-playground-scripts/blob/master/task-consul-run-instance.sh
* :white_check_mark: Dashboard: http://35.234.127.135:8500/ui
* :white_check_mark: Sample CLI: `consul members`

### :white_check_mark: Nomad

Scheduler for services

* :white_check_mark: Install: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-install.sh
* :white_check_mark: Run: https://github.com/kospiotr/us-playground-scripts/blob/master/task-nomad-run.sh
* :white_check_mark: Dashboard: http://35.234.127.135:4646/ui
* :white_check_mark: Sample CLI: `nomad server members`
* :white_check_mark: Clean dead jobs: `curl -X PUT http://35.234.127.135:4646/v1/system/gc`

### :black_square_button: Micro Services

* :white_check_mark: Sample App walkthrough (https://github.com/kospiotr/us-playground-scripts/tree/master/u-service-hello)
* :white_check_mark: Registration in Service Discovery
* :white_check_mark: Deploy 1 service:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O u-service-hello-ocd.job.nomad && nomad job run u-service-hello-ocd.job.nomad
```

* :black_square_button: Deploy 2 service:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-another-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O u-service-another-ocd.job.nomad && nomad job run u-service-another-ocd.job.nomad
```

* Rest Endpoints
  * Main (/) - default entrypoint displaying Hello World
  * Healthcheck (/my-health-check) - healthcheck for service discovery and or gateway 
  * Inspect (/inspect) - displaying app instance info
    * \?delay - sleep value in ms 
  
### :black_square_button: Api Gateway

#### :white_check_mark: Linkerd

* :white_check_mark: Source code: https://github.com/kospiotr/us-playground-scripts/tree/master/linkerd-ocd
* :white_check_mark: Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts

wget "${REPO}/${BRANCH}/linkerd-ocd/${ENVIRONMENT}/deploy.job.nomad?nocache" -O linkerd.job.nomad && nomad job run linkerd.job.nomad
```

#### :black_square_button: Spring Gateway

* :white_check_mark: Code: https://github.com/kospiotr/us-playground-scripts/tree/master/linkerd-ocd
* :white_check_mark: Deploy:

```
export BRANCH=master
export ENVIRONMENT=dev
export REPO=https://raw.githubusercontent.com/kospiotr/us-playground-scripts
wget "${REPO}/${BRANCH}/u-service-hello-ocd/${ENVIRONMENT}/job.nomad?nocache" -O u-service-hello-ocd.job.nomad && nomad job run u-service-hello-ocd.job.nomad
```

* :white_check_mark: Dashboard: http://35.234.75.13:9990/?router=http
* HelloWorld app:
  * :black_square_button: Root: http://35.234.75.13:4140/api/v1/helloWorldApp/
  * :black_square_button: Inspect: http://35.234.75.13:4140/api/v1/helloWorldApp/inspect
* Another app:
  * :black_square_button: Root: http://35.234.75.13:4140/api/v1/anotherApp/
  * :black_square_button: Inspect: http://35.234.75.13:4140/api/v1/anotherApp/inspect  

### :black_square_button: Scale
### :black_square_button: Testing

* Load tests
* Chaos tests

