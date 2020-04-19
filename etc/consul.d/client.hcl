bootstrap = false
server = false
encrypt = "xQ1VJEybm2YsBfedFhrLI6e9lV+iE/7ODzq8kvw3X2Y="
log_level = "INFO"
enable_syslog = true
retry_join = ["provider=mdns service=consul domain=local"]
advertise_addr = "{{ GetPrivateIP }}"