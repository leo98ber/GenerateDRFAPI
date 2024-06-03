#!/bin/bash

chown www-data:www-data -R /var/log/apache2/api &&
touch /var/log/apache2/api/api-error.log &&
touch /var/log/apache2/api/api-access.log &&
echo "Directories already created"

touch /etc/apache2/sites-available/api.conf
sleep 5
echo "File api.conf already created"
cd /etc/apache2/sites-available/
path=`pwd`
echo "${path}"
a2ensite api.conf
service apache2 restart

tail -f /dev/null