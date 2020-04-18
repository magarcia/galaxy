bootstrap = true
server = true
encrypt = "xQ1VJEybm2YsBfedFhrLI6e9lV+iE/7ODzq8kvw3X2Y="
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
ui = true
addresses = {
  http = "0.0.0.0"
}
bind_addr = "0.0.0.0"
advertise_addr = "{{ GetInterfaceIP \"eth0\" }}"
