job "u-service-hello-service" {
    datacenters = ["dc1"]
    type = "service"
    group "u-service-hello-group" {
        count = 1
        task "u-service-hello-task" {
            driver = "java"
            artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/microservice_consul_1-0.0.1-SNAPSHOT.jar"
            }
            config {
                jar_path    = "local/microservice_consul_1-0.0.1-SNAPSHOT.jar"
                jvm_options = ["-Xmx256m", "-Xms128m", "-Dserver.port=${NOMAD_PORT_http}"]
            }
            resources {
                cpu    = 500
                memory = 300
                network {
                    port "http" {}
                }
            }
            service {
                name = "u-service-hello-service"
                port = "http"
            }
        }
        restart {
            attempts = 1
        }
    }
}
