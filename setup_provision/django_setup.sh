#!/usr/bin/env bash

# this input is determined in the Vagrantfile. It is one of the following:
# - a predefined ip for private network setup during local development
# - an ip discovered through a DNS server; this is the case when deploying
read MY_IP

source /vagrant/setup_sessionconfig/export_venvwrapper_vars.sh
workon proj

cp /vagrant/proj/myproject/settings/allowed_hosts.py_template /vagrant/proj/myproject/settings/allowed_hosts.py
sed -i -e "s/VARIABLE_IP/$MY_IP/" /vagrant/proj/myproject/settings/allowed_hosts.py
python manage.py migrate
echo yes | python manage.py collectstatic