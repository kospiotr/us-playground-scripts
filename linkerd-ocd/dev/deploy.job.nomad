job "linkerd-service" {
    datacenters = ["dc1"]
    type = "service"
    group "linkerd-group" {
        count = 1
        task "linkerd-task" {
            driver = "exec"
            artifact {
              source = "https://github.com/kospiotr/us-playground-scripts/releases/download/0.0.0-SNAPSHOT/microservice_consul.jar"
            }
            resources {
                cpu    = 500
                memory = 300
                network {
                    port "routers" {
                      static = 4140
                    }
                    port "admin" {
                      static = 9990
                    }
                }
            }
            service {
                name = "linkerd-service"
                portRouters = "routers"
                portAdmin = "admin"
            }
        }
        restart {
            attempts = 1
        }
    }
}
