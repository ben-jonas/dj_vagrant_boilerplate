#!/usr/bin/env bash
source /vagrant/setup_sessionconfig/export_venvwrapper_vars.sh
workon proj
python manage.py migrate
echo yes | python manage.py collectstatic