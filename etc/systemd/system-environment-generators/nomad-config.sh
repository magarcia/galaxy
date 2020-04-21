#!/usr/bin/env bash

case $(hostname -s) in
    sun|node1|node2|node3) CONFIG=/etc/nomad.d/server.hcl ;;
    *) CONFIG=/etc/nomad.d/client.hcl ;;
esac

echo NOMAD_CONFIG=$CONFIG