## Quantum Legacy
### A C2 server for Honeypots. 


reminder make the database for users

docker-compose run --rm hpfeeds sqlite3 sqlite.db
INSERT INTO authkeys (owner, ident, secret, pubchans, subchans) VALUES ('owner', 'main', 'verysecret', '["cowrie"]', '["cowrie"]');

chmod 777 storage...


