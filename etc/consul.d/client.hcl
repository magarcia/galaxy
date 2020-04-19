bootstrap = false
server = false
log_level = "INFO"
enable_syslog = true
retry_join = ["provider=mdns service=consul domain=local"]
advertise_addr = "{{ GetPrivateIP }}"