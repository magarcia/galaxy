bootstrap = false
server = false
log_level = "INFO"
enable_syslog = true
retry_join = ["provider=mdns service=consul domain=local"]
client_addr = "127.0.0.1 {{ GetInterfaceIP  \"docker0\" }}"
advertise_addr = "{{ GetPrivateIP }}"