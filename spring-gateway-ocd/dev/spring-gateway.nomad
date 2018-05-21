job "spring-gateway" {
    datacenters = ["dc1"]
    type = "service"
    group "caller" {
        count = 1
        task "api" {
            driver = "java"
			 artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/spring-gateway-ocd.jar"
            }
			 artifact {
              source = "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/spring-gateway-ocd/dev/application.yml"
            }
            config { # (3)
                jar_path    = "local/spring-gateway-ocd.jar"
                jvm_options = ["-Xmx512m", "-Xms512m","-Dspring.config.location=file:local/application.yml"]
            }
            resources { # (4)
                cpu    = 1000
                memory = 1000
                network {
                    port "http" {} # (5)
                }
            }
            service { # (6)
                name = "spring-gateway"
                port = "http"
            }
        }
        restart {
            attempts = 1
        }
    }
}
