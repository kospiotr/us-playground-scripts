job "linkerd-service" {
    datacenters = ["dc1"]
    type = "service"
    group "linkerd-group" {
        count = 1
        task "linkerd-task" {
            driver = "exec"
            artifact {
              source = "https://github-production-release-asset-2e65be.s3.amazonaws.com/49605596/b8a21c10-4c92-11e8-9e14-7d2302a31937?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20180518%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180518T062910Z&X-Amz-Expires=300&X-Amz-Signature=d5a5875bc036709982a15b0e6c009775853bc464301d66a8d10a28ae3782eeb2&X-Amz-SignedHeaders=host&actor_id=1245635&response-content-disposition=attachment%3B%20filename%3Dlinkerd-1.4.0.tgz"
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
