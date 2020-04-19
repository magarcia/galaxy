bootstrap = true
server = true
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
ui = true
addresses = {
  http = "0.0.0.0"
}
client_addr = "127.0.0.1 {{ GetInterfaceIP  \"docker0\" }}"
bind_addr = "0.0.0.0"
advertise_addr = "{{ GetPrivateIP }}"
