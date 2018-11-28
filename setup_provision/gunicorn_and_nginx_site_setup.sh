#!/usr/bin/env bash

# this input is determined in the Vagrantfile. It is one of the following:
# - a predefined ip for private network setup during local development
# - an ip discovered through a DNS server; this is the case when deploying
read MY_IP

echo "Configuring nginx and gunicorn"

# add gunicorn service to systemd (reminder: its activation is left to Vagrant, not
# systemd at startup)
cp /vagrant/service/gunicorn.service /etc/systemd/system/gunicorn.service

# configure nginx to proxy gunicorn service
cp /vagrant/service/nginx_sites_available/myproject /etc/nginx/sites-available
sed -i -e "s/VARIABLE_IP/$MY_IP/" /etc/nginx/sites-available/myproject
ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled

# allow nginx through firewall
ufw allow 'Nginx Full'

# test the configuration file
nginx -t

systemctl restart nginx