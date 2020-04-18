#!/usr/bin/env bash

ARCH=$(uname -m)
RELEASE_URL="https://api.github.com/repos/prometheus/node_exporter/releases/latest"
BASE_DOWNLOAD_URL="https://github.com/prometheus/node_exporter/releases/download/%s/node_exporter-%s.linux-%s.tar.gz"

RELEASE=$(curl -s $RELEASE_URL)

TAG_NAME=$(echo $RELEASE | jq '.tag_name' | tr -d '"')
VERSION=${TAG_NAME//v}

# Get arch code
ARCH_CODE='386'
if [[ $ARCH == *"arm"* ]]; then
    ARCH_CODE="armv6"
fi
if [[ $ARCH == *"aarch64"* ]]; then
    ARCH_CODE='arm64'
fi
if [[ $ARCH == *"x86_64"* ]]; then
    ARCH_CODE="amd64"
fi


DOWNLOAD_URL=$(printf "${BASE_DOWNLOAD_URL}" $TAG_NAME $VERSION $ARCH_CODE)

echo -n "Downloading node_exporter $VERSION..."

curl -s -L -o node_exporter.tar.gz $DOWNLOAD_URL
tar -zxf node_exporter.tar.gz
rm node_exporter.tar.gz

mv node_exporter-${VERSION}.linux-${ARCH_CODE}/node_exporter node_exporter
rm -r node_exporter-${VERSION}.linux-${ARCH_CODE}

echo " DONE"