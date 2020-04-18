#!/usr/bin/env bash

ARCH=$(uname -m)
RELEASES_URL="https://api.github.com/repos/hashicorp/nomad/releases"
BASE_DOWNLOAD_URL="https://releases.hashicorp.com/nomad/%s/nomad_%s_linux_%s.zip"

TAG_NAME=$(curl -s $RELEASES_URL | jq 'map(select(.prerelease == false))[0].name' | tr -d '"')
VERSION=${TAG_NAME//v}

# Get arch code
ARCH_CODE='386'
if [[ $ARCH == *"arm"* ]]; then
    ARCH_CODE='arm'
fi
if [[ $ARCH == *"aarch64"* ]]; then
    ARCH_CODE='arm64'
fi
if [[ $ARCH == *"x86_64"* ]]; then
    ARCH_CODE="amd64"
fi


DOWNLOAD_URL=$(printf "${BASE_DOWNLOAD_URL}" $VERSION $VERSION $ARCH_CODE)

echo -n "Downloading nomad $VERSION... "

curl -s -L -o nomad.zip $DOWNLOAD_URL
unzip -qq nomad.zip
rm nomad.zip

echo " DONE"
