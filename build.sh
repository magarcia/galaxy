#!/usr/bin/env bash

# Elevate privileges
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

apt install jq unzip

# Download tools
./download/nomad.sh
./download/consul.sh
./download/node_exporter.sh

# Setup applications
mkdir -p /usr/local/bin

## Consul
cp -r ./etc/consul.d /etc/
mkdir -p /var/consul
useradd --system --home /etc/consul.d --shell /bin/false consul
chown consul:consul consul
mv ./consul /usr/local/bin/
chmod 640 /etc/consul.d/*
chown --recursive consul:consul /var/consul

## Nomad
cp -r ./etc/nomad.d /etc/
mkdir -p /var/nomad
mv ./nomad /usr/local/bin/
chmod 640 /etc/nomad.d
chown --recursive nomad:nomad /var/nomad

## Node Exporter
useradd -rs /bin/false node_exporter
cp -r ./etc/sysconfig /etc/
mkdir -p /var/nomad
chown --recursive node_exporter:node_exporter /var/node_exporter
chown node_exporter:node_exporter node_exporter
mv ./node_exporter /usr/local/bin/


# Start services

cp -r ./etc/systemd/* /etc/systemd/

## Consul
systemctl enable consul
systemctl start consul
## Nomad
systemctl enable nomad
systemctl start nomad
## Node Exporter
systemctl enable node_exporter
systemctl start node_exporter



systemctl status consul
systemctl status nomad
systemctl status node_exporter