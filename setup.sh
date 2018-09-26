#!/bin/bash

# RUN as root
# should check that
if ! [ $(id -u) = 0 ]; then
    echo "I need root privs pleaseeee"
    exit 1
fi

curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Should maybe check for a new version every so often...
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

chmod 777 storage/elasticsearch
