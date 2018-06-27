#!/usr/bin/env bash
apt-get update
apt-get install -y python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx 
pip3 install virtualenv virtualenvwrapper
