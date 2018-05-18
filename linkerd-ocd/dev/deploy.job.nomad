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
            config {
              command = "my-binary"
              args    = ["-flag", "1"]
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
