Running Spring Gateway OCR

```
1. Build with maven (mvn clean install)
2. Run java -jar ./spring-gateway-ocd.jar -Dspring.config.location=file:application.yml
```

Routing Refresh

```
POST to appHost:appPort/actuator/refresh
```