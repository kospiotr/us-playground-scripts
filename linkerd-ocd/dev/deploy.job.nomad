job "linkerd-job" {
    datacenters = ["dc1"]
    type = "system"
    group "caller" {
        count = 1
        task "linkerd-task" {
            driver = "java"
            artifact {
              source = "https://github.com/linkerd/linkerd/releases/download/${LINKERD_VERSION}/linkerd-${LINKERD_VERSION}.tgz"
            }
            config {
                jar_path    = "local/microservice_consul.jar"
                jvm_options = ["-Xmx256m", "-Xms128m", "-Dserver.port=${NOMAD_PORT_http}"]
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
