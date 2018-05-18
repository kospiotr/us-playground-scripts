job "linkerd-service" {
    datacenters = ["dc1"]
    type = "service"
    group "linkerd-group" {
        count = 1
        task "linkerd-task" {
            driver = "exec"
            artifact {
              source = "https://github.com/linkerd/linkerd/releases/download/1.4.0/linkerd-1.4.0.tgz"
            }
            artifact {
              source = "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/PK/linkerd-ocd/dev/linkerd.yaml"
            }
            config {
              command = "local/linkerd-1.4.0/linkerd-1.4.0-exec"
              args    = ["local/config.yaml"]
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
            }
        }
        restart {
            attempts = 1
        }
    }
}
