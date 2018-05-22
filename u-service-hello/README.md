## Build

`mvn clean install`

Run jar:

```
cd target
java -jar microservice_consul_1-0.0.1-SNAPSHOT.jar
```

Release

```
#INIT
export GITHUB_TOKEN=__TOKEN_HERE__
go get github.com/aktau/github-release

#SET-UP
export APP_VERSION=0.0.1-SNAPSHOT

#BUMP VERSION
git pull
mvn versions:set -DnewVersion=${APP_VERSION} -DgenerateBackupPoms=false -X
git add --all && git commit -m "Bump version to ${APP_VERSION}" && git push

#BUILD APP
mvn clean install

#UPLOAD BINARY FILE
github-release upload \
    --user kospiotr \
    --repo us-playground-scripts \
    --tag 0.0.0-SNAPSHOT \
    --name "microservice_using_consul.jar" \
    --file target/microservice_using_consul-${APP_VERSION}.jar
```
