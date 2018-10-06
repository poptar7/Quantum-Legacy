#!/bin/bash

# RUN as root
# should check that
if ! [ $(id -u) = 0 ]; then
    echo "I need root privs pleaseeee"
    exit 1
fi
if [ ! -f get-docker.sh ]; then
    curl -fsSL get.docker.com -o get-docker.sh
    sh get-docker.sh
fi
echo Hopefully docker is actually installed.
echo If its not then just run 'sh get-docker.sh'.

# Should maybe check for a new version every so often...
curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo Hopefully docker-compose is now installed
# I know there is a way to check if the command exists should add that at some point

chmod 777 storage/elasticsearch

echo chmod 777 hopefully ran on the elasticsearch directory

echo Now for a question or two for you.
echo Do you want to use certbot or self signed certs (c/s)
read input
if [ $input == "c" ]; then
    echo What domain is your server running on?
    read input
    apt-get install -y software-properties-common
    add-apt-repository -y ppa:certbot/certbot
    apt-get update -y
    apt-get install -y certbot
    certbot certonly --standalone --cert-name server_certs -n -d $input
    cp /etc/letsencrypt/live/server_certs/fullchain.pem ./nginx/ssl/fullchain.pem
    cp /etc/letsencrypt/live/server_certs/cert.pem ./nginx/ssl/cert.pem
elif [ $input == "s" ]; then
    openssl req -x509 -nodes -new -batch -keyout nginx/ssl/server.key -out nginx/ssl/server.crt
else
    echo Must use c or s for certbot or self signed.
fi
