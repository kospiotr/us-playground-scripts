job "spring-gateway" {
    datacenters = ["dc1"]
    type = "system"
    group "spring-gateway-group" {
        count = 1
        task "spring-gateway-task" {
            driver = "java"
			 artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/spring-gateway.jar"
            }
			 artifact {
              source = "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/master/spring-gateway-ocd/dev/application.yml"
            }
            config { # (3)
                jar_path    = "local/spring-gateway.jar"
                jvm_options = ["-Xmx512m", "-Xms512m","-Dspring.config.location=file:local/application.yml"]
            }
            resources { # (4)
                cpu    = 300
                memory = 600
		network {
                    port "router" {
                        static = 4141
                    }
		}
            }
            service { # (6)
                name = "spring-gateway-service"
                port = "router"
            }
        }
        restart {
            attempts = 1
        }
    }
}
