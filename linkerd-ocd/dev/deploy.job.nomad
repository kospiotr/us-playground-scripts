job "linkerd-job" {
    datacenters = ["dc1"]
    type = "service"
    group "linkerd-group" {
        count = 1
        
        }
        restart {
            attempts = 1
        }
    }
}
