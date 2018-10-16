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

mkdir /opt/client
cd /opt/client

# Port stuff
# On host change what port sshd is on and restart it
sed -i 's/#port 22/port 22222/g
s/port 22/port 22222/g' /etc/ssh/sshd_config
service sshd restart

docker-compose build
docker-compose up

## Begin no docker

# DO debian does not have git by default
#apt-get install git

#git clone https://github.com/cowrie/cowrie.git
#apt-get install --no-install-recommends -y libffi6 python3 python3-pip python3-setuptools build-essential libssl-dev libffi-dev python3-dev libsnappy-dev default-libmysqlclient-dev
#cd cowrie
#pip3 install -r requirements.txt
#adduser --system --shell /bin/bash --group --disabled-password cowrie
# Failed building wheel a few times yet everything installed?

## End no docker
# Toss our cowrie directory from central command into the cloned directory

# Now we need to add the config for this setup

# Insert more pre reqs for the docker config to work




# K so we have "cowrie" Now we need filebeats to dump the good stuff

