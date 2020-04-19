#!/usr/bin/env bash

case $(hostname -s) in
    sun) CONFIG=/etc/consul.d/bootstrap.hcl ;;
    node1|node2|node3|black-pearl) CONFIG=/etc/consul.d/server.hcl ;;
    *) CONFIG=/etc/consul.d/client.hcl ;;
esac

MODEL=$(cat /proc/device-tree/model  2> /dev/null || lscpu | grep "Model name" | awk '{for(i=3;i<=NF;++i)printf $i" "}{print ""}')
echo CONSUL_CONFIG=$CONFIG
echo NODE_META="-node-meta arch:$(uname -m) -node-meta model:\"$MODEL\" -node-meta os:${uname -o}"
