#!/bin/bash

# RUN as root
# should check that
if ! [ $(id -u) = 0 ]; then
    echo "I need root privs pleaseeee"
    exit 1
fi
apt install -y curl
if [ ! -f get-docker.sh ]; then
    curl -fsSL get.docker.com -o get-docker.sh
    sh get-docker.sh
fi
echo Hopefully docker is actually installed.
echo If its not then just run 'sh get-docker.sh'.

# Should maybe check for a new version every so often...
if [ ! -d /usr/local/bin/docker-compose ]; then
    curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

echo Hopefully docker-compose is now installed
if [ ! -d /opt/client ]; then
    mkdir /opt/client
fi
cd /opt/client

# Port stuff
# On host change what port sshd is on and restart it
sed -i 's/#port 22/port 22222/g
s/port 22/port 22222/g' /etc/ssh/sshd_config
service sshd restart

chmod -R 777 cowrie

docker-compose build
# Now we need to add the config for this setup
docker-compose up




# K so we have "cowrie" Now we need filebeats to dump the good stuff

