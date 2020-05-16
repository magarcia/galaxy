bootstrap = false
server = true
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
retry_join = ["provider=mdns service=consul domain=local", "sun.local"]
ui = true
client_addr = "127.0.0.1 {{ GetInterfaceIP  \"docker0\" }}"
advertise_addr = "{{ GetPrivateIP }}"