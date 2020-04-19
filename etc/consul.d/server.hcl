bootstrap = false
server = true
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
retry_join = ["provider=mdns service=consul domain=local"]
ui = true
advertise_addr = "{{ GetPrivateIP }}"