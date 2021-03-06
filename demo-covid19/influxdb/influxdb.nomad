job "influxdb" {
  datacenters = ["dc1"]

  group "influxdb" {
    count = 1

		task "influxdb" {
      driver = "docker"

      artifact {
        source      = "https://raw.githubusercontent.com/xaviermerino/nomad-jobs/master/demo-covid19/influxdb/influxdb.conf"
        destination = "/local/"
      }

      artifact {
        source      = "https://raw.githubusercontent.com/xaviermerino/nomad-jobs/master/demo-covid19/influxdb/influxdb-init.iql"
        destination = "/local/"
      }

      config {
        image = "influxdb"
        args = [
          "-config", "/etc/influxdb/influxdb.conf"
        ]
        
        port_map {
          http = 8086
        }

        volumes = [
          "local/influxdb.conf:/etc/influxdb/influxdb.conf",
          "local/influxdb-init.iql:/docker-entrypoint-initdb.d/influxdb-init.iql"
        ]
      }

      resources {
        cpu = 500 
        memory = 300 
        network {
          mbits = 100
          port "http" {
            static = 8086
          }
        }
      }

      service {
        name = "influxdb"
        port = "http"
        check {
          name     = "Influx Ping"
          type     = "http"
          path     = "/ping?verbose=true"
          interval = "5s"
          timeout  = "2s"
        }
      }

		} # End task
	} # End group

} # End job
