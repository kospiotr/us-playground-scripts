job "u-service-app2-service" {
    datacenters = ["dc1"]
    type = "service"
    group "u-service-app2-group" {
        count = 3
        task "u-service-app2-task" {
            driver = "java"
            artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/microservice_using_consul.jar"
            }
            artifact {
              source = "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/u-service-app2-ocd/dev/application.yml"
            }
            config {
                jar_path    = "local/microservice_using_consul.jar"
                jvm_options = ["-Xmx256m", "-Xms128m", "-Dspring.config.location=file:local/application.yml"]
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
