data_dir = "/var/nomad"
log_level = "DEBUG"
enable_debug = true
bind_addr = "0.0.0.0"
disable_update_check = true

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}

consul {
    address = "127.0.0.1:8500"
}

client {
  enabled = true
}