#!/bin/sh
set -e

#echo "Displaying username:"
#whoami
#mkdir /vol/web/static/admin
#echo "displaying permissions to /vol/web"
#ls -la /vol/web
#echo "displaying permissions to /vol/web/static/admin"
#ls -la /vol/web/static/admin
python manage.py wait_for_db
python manage.py collectstatic --noinput
python manage.py migrate

uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi
