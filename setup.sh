#!/bin/bash

# RUN as root
if ! [ $(id -u) = 0 ]; then
    echo "I need root privs pleaseeee"
    exit 1
fi

#ERROR Will not remove previous failures
# Setup the central server ip
ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo
echo ----------------------------------------
echo This will use $ip for all clients connecting to the server.
echo The variable is "CENTRAL_IP"
echo ----------------------------------------
echo After the setup finishes the server will need to restart to implement this.
echo ----------------------------------------
echo

# Check that this is not already set !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
env="CENTRAL_IP=\"$ip\""
echo $env >> /etc/environment

apt-get -y install rsync curl

# If it is already installed but the file is not there it will be confused.
# Maybe do something like which docker?
if [ ! -f get-docker.sh ]; then
    curl -fsSL get.docker.com -o get-docker.sh
    sh get-docker.sh
fi
# Should maybe check for a new version every so often...
if [ ! -d /usr/local/bin/docker-compose ]; then
    curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

chmod 777 storage/elasticsearch

echo Will restart on next key press
read input
shutdown -r now









#  RE ADD when needed

#echo Now for a question or two for you.
#echo Do you want to use certbot or self signed certs (c/s)
#read input
#if [ $input == "c" ]; then
#    echo What domain is your server running on?
#    read input
#    apt-get install -y software-properties-common
#    add-apt-repository -y ppa:certbot/certbot
#    apt-get update -y
#    apt-get install -y certbot
#    certbot certonly --standalone --cert-name server_certs -n -d $input
#    cp /etc/letsencrypt/live/server_certs/fullchain.pem ./nginx/ssl/fullchain.pem
#    cp /etc/letsencrypt/live/server_certs/cert.pem ./nginx/ssl/cert.pem
#elif [ $input == "s" ]; then
#    openssl req -x509 -nodes -new -batch -keyout nginx/ssl/server.key -out nginx/ssl/server.crt
#else
#    echo Must use c or s for certbot or self signed.
#fi
