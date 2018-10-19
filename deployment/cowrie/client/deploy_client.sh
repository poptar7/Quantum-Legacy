#!/bin/bash

# RUN as root
if ! [ $(id -u) = 0 ]; then
    echo "I need root privs pleaseeee"
    exit 1
fi
# Curl may not be installed - install other missing reqs as well
apt install -y curl

if [ ! -f get-docker.sh ]; then
    curl -fsSL get.docker.com -o get-docker.sh
    sh get-docker.sh
fi
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


#THIS IS BORKED AS FUCK :)
# Port stuff
# On host change what port sshd is on and restart it
#sed -i 's/#\s*Port 22/Port 22222/g
#s/Port 22/Port 22222/g' /etc/ssh/sshd_config
sed -i '/Port 22/s/.*/Port 22222/' /etc/ssh/sshd_config
service sshd restart

chmod -R 777 cowrie

docker-compose build
# Config needs to be added at some point before starting
docker-compose up -d




# K so we have "cowrie" Now we need filebeats to dump the good stuff

