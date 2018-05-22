job "u-service-app1-service" {
    datacenters = ["dc1"]
    type = "service"
    group "u-service-app1-group" {
        count = 5
        task "u-service-app1-task" {
            driver = "java"
            artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/microservice_using_consul-0.0.3-SNAPSHOT.jar"
            }
            config {
                jar_path    = "local/microservice_consul_1-0.0.1-SNAPSHOT.jar"
                jvm_options = ["-Xmx256m", "-Xms128m", "-Dserver.port=${NOMAD_PORT_http}", "-Dspring.cloud.consul.host=localhost", "-Dspring.application.name=u-service-app-1"]
            }
            resources {
                cpu    = 500
                memory = 300
                network {
                    port "http" {}
                }
            }
        }
        restart {
            attempts = 1
        }
    }
}
