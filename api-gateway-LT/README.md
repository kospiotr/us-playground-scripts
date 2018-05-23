## Set up

```
# Install JMeter
wget "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/apache-jmeter-3.0.zip" -O jmeter.zip
unzip jmeter.zip
sudo chmod +x apache-jmeter-3.0
```

## Run load test

```
wget "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/api-gateway-LT/linkerd_and_spring.jmx?$(uuidgen)" -O linkerd_and_spring.jmx
sh apache-jmeter-3.0/bin/jmeter -n -t linkerd_and_spring.jmx
```
