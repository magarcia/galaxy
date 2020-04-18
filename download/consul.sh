#!/usr/bin/env bash

ARCH=$(uname -m)
RELEASES_URL="https://api.github.com/repos/hashicorp/consul/tags"
BASE_DOWNLOAD_URL="https://releases.hashicorp.com/consul/%s/consul_%s_linux_%s.zip"

TAG_NAME=$(curl -s $RELEASES_URL | jq 'map(select(.name | contains("-") | not))[0].name' | tr -d '"')
VERSION=${TAG_NAME//v}

# Get arch code
ARCH_CODE='386'
if [[ $ARCH == *"arm"* ]]; then
    ARCH_CODE=$(readelf -a /proc/self/exe | grep -q -c Tag_ABI_VFP_args && echo "armhfv6" || echo "armelv5")
fi
if [[ $ARCH == *"aarch64"* ]]; then
    ARCH_CODE='arm64'
fi
if [[ $ARCH == *"x86_64"* ]]; then
    ARCH_CODE="amd64"
fi


DOWNLOAD_URL=$(printf "${BASE_DOWNLOAD_URL}" $VERSION $VERSION $ARCH_CODE)

echo -n "Downloading consul $VERSION..."

curl -s -L -o consul.zip $DOWNLOAD_URL
unzip -qq consul.zip
rm consul.zip

echo " DONE"