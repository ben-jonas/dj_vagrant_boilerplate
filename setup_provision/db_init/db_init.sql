CREATE DATABASE :project;
CREATE USER :usr WITH PASSWORD :'pass';
ALTER ROLE :usr SET client_encoding TO 'utf-8';
ALTER ROLE :usr SET default_transaction_isolation TO 'read committed';
ALTER ROLE :usr SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE :project TO :usr;