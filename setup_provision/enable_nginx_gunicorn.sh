#!/usr/bin/env bash
cp /vagrant/service/nginx_sites_available/myproject /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
nginx -t
systemctl restart nginx
sudo ufw allow 'Nginx Full'