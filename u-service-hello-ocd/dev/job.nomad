job "caller-service" {
    datacenters = ["dc1"]
    type = "service"
    group "caller" {
        count = 5
        task "api" {
            driver = "java"
            artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/microservice_consul_1-0.0.1-SNAPSHOT.jar"
            }
            config {
                jar_path    = "local/microservice_consul.jar"
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
                name = "caller-service"
                port = "http"
            }
        }
        restart {
            attempts = 1
        }
    }
}
