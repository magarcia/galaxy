#!/usr/bin/env bash

# Elevate privileges
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

apt update
apt install jq unzip git libnss-mdns avahi-utils

curl -s -L https://github.com/magarcia/galaxy/archive/master.zip -o /tmp/master.zip
cd /tmp
unzip -qq master.zip
cd galaxy-master/

# Download tools
./download/nomad.sh
./download/consul.sh
./download/node_exporter.sh
./download/vault.sh

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
chown --recursive consul:consul /etc/consul.d

## Vault
cp -r ./etc/vault.d /etc/
useradd --system --home /etc/vault.d --shell /bin/false vault
chown vault:vault vault
mv ./vault /usr/local/bin/
setcap cap_ipc_lock=+ep /usr/local/bin/vault
chmod 640 /etc/vault.d/*
chown --recursive vault:vault /etc/vault.d

## Nomad
cp -r ./etc/nomad.d /etc/
mkdir -p /var/nomad
mv ./nomad /usr/local/bin/
chmod 640 /etc/nomad.d
chown --recursive nomad:nomad /var/nomad
chown --recursive nomad:nomad /etc/nomad.d

## Node Exporter
useradd -rs /bin/false node_exporter
cp -r ./etc/sysconfig /etc/
mkdir -p /var/node_exporter
chown --recursive node_exporter:node_exporter /var/node_exporter
chown node_exporter:node_exporter node_exporter
mv ./node_exporter /usr/local/bin/


# Start services

cp -r ./etc/systemd/* /etc/systemd/
systemctl daemon-reload

## Consul
systemctl enable consul
systemctl start consul
## Vault
systemctl enable vault
systemctl start vault
## Nomad
systemctl enable nomad
systemctl start nomad
## Node Exporter
systemctl enable node_exporter
systemctl start node_exporter

cd ..
rm -r master.zip galaxy-master