#!/usr/bin/env bash

case $(hostname -s) in
    sun) CONFIG=/etc/consul.d/bootstrap.hcl ;;
    node1|node2|node3) CONFIG=/etc/consul.d/server.hcl ;;
    *) CONFIG=/etc/consul.d/client.hcl ;;
esac

trim(){
    [[ "$1" =~ [^[:space:]](.*[^[:space:]])? ]]
    printf "%s" "$BASH_REMATCH"
}

MODEL=$(trim "$(cat /proc/device-tree/model  2> /dev/null || lscpu | grep "Model name" | awk '{for(i=3;i<=NF;++i)printf $i" "}{print ""}')" | tr " " "_")
OS=$(uname -o)
ARCH=$(uname -m)

echo CONSUL_CONFIG=$CONFIG
echo ARCH="arch:$ARCH"
echo MODEL="model:$MODEL"
echo OS="os:$OS"