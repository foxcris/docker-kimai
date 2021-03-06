#!/bin/bash

if [ `ls /etc/apache2/sites-available/ | wc -l` -eq 0 ]
then
  cp -r /etc/apache2/sites-available_default/* /etc/apache2/sites-available/
fi

if [ `ls /etc/letsencrypt/ | wc -l` -eq 0 ]
then
  cp -r /etc/letsencrypt_default/* /etc/letsencrypt/
fi

find /var/www/html/includes ! -name 'autoconf.php' -type f -exec rm -f {} +
cp -r /var/www/html/includes_default/* /var/www/html/includes/
chown www-data:www-data /var/www/html/includes

if [ -f /var/www/html/includes/autoconf.php ]
then
  rm -r /var/www/html/installer
fi

#List site and enable
ls /etc/apache2/sites-available/ -1A | a2ensite *.conf

#LETSECNRYPT
if [ "$LETSENCRYPTDOMAINS" != "" ]
then
  /usr/sbin/apache2ctl start
  domains=$(echo $LETSENCRYPTDOMAINS | tr "," "\n")
  for domain in $domains
  do
    certbot --apache -n -d $domain --agree-tos --email $LETSENCRYPTEMAIL
  done
  /usr/sbin/apache2ctl stop
fi

#Start Cron
/etc/init.d/anacron start
/etc/init.d/cron start

#Launch Apache on Foreground
/usr/sbin/apache2ctl -D FOREGROUND
