#!/usr/bin/env bash
cp /vagrant/service/gunicorn.service /etc/systemd/system/gunicorn.service
cp /vagrant/service/nginx_sites_available/myproject /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
ufw allow 'Nginx Full'
nginx -t
systemctl restart nginx