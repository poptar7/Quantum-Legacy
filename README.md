## Quantum Legacy
### A C2 server for Honeypots. 


reminder make the database for users

docker-compose run --rm hpfeeds sqlite3 sqlite.db
INSERT INTO authkeys (owner, ident, secret, pubchans, subchans) VALUES ('owner', 'main', 'verysecret', '["cowrie"]', '["cowrie"]');

chmod 777 storage...


$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update
$ sudo apt-get install certbot 


$ sudo certbot certonly --standalone -d example.com -d www.example.com