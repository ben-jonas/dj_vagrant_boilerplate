#!/usr/bin/env bash
echo "Creating and enabling Gunicorn service"
cp /vagrant/service/gunicorn.service /etc/systemd/system
systemctl start gunicorn
systemctl enable gunicorn
systemctl status gunicorn