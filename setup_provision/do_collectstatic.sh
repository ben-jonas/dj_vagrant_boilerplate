#!/usr/bin/env bash
source /vagrant/setup_sessionconfig/export_venvwrapper_vars.sh
workon proj
echo yes | python manage.py collectstatic