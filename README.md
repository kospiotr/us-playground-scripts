# us-playground-scripts

Running for bootstrap VM:

```
export BRANCH=master
sudo su -c "bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/startup-bootstrap.sh?nocache") $BRANCH > install.log" root && cat install.log
```

Running for server VM:

```
export BRANCH=master
sudo su -c "bash <(wget -qO- "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/${BRANCH}/startup-server.sh?nocache") $BRANCH > install.log" root && cat install.log
```
