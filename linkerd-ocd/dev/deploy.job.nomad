job "linkerd-job" {
    datacenters = ["dc1"]
    type = "service"
    group "caller" {
        count = 1
        task "linkerd-task" {
            driver = "exec"
            artifact {
              source = "https://github.com/linkerd/linkerd/releases/download/1.4.0/linkerd-1.4.0.tgz"
            }
            artifact {
              source = "https://raw.githubusercontent.com/kospiotr/us-playground-scripts/PK/linkerd-ocd/dev/linkerd.yaml?nocache"
            }
            resources {
                cpu    = 500
                memory = 300
                network {
                    routers "routers" {
                      static = 4140
                    }
                    admin "admin" {
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
