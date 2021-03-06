# config file version
apiVersion: 1

# list of datasources to insert/update depending
# whats available in the database
datasources:

- name: InfluxDB
  type: influxdb
  access: proxy
  database: covid19
  user: 
  url: http://{{ range service "influxdb" }}{{ .Address }}:{{ .Port }}{{ end }}
  jsonData:
    timeInterval: "15s"
  secureJsonData:
    password: 