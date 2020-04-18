#!/usr/bin/env bash

case $(hostname -s) in
    sun) CONFIG=/etc/consul.d/bootstrap.hcl ;;
    node1|node2|node3) CONFIG=/etc/consul.d/server.hcl ;;
    *) CONFIG=/etc/consul.d/client.hcl ;;
esac

echo CONSUL_CONFIG=$CONFIG
