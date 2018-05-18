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
