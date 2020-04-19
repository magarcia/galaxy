bootstrap = false
server = true
encrypt = "xQ1VJEybm2YsBfedFhrLI6e9lV+iE/7ODzq8kvw3X2Y="
log_level = "INFO"
enable_syslog = true
data_dir = "/var/consul"
retry_join = ["provider=mdns service=consul domain=local"]
ui = true
advertise_addr = "{{ GetPrivateIP }}"