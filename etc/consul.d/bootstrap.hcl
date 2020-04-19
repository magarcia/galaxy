bootstrap = true
server = true
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
ui = true
addresses = {
  http = "0.0.0.0"
}
bind_addr = "0.0.0.0"
advertise_addr = "{{ GetPrivateIP }}"
