#!/bin/bash

cd /usr/local/src && apt install wget -y
echo 'Pick :'
echo '1) Debian'
echo '2) Ubuntu'

read choice

if [ $choice -eq "1" ];
then
	wget https://raw.githubusercontent.com/ech1/serverside/master/nextcloud/debian_install.sh
	mv debian_install.sh install_next.sh
else
	wget https://raw.githubusercontent.com/ech1/serverside/master/nextcloud/ubuntu_install.sh
	mv ubuntu_install.sh install_next.sh
fi

chmod +x install_next.sh
./install_next.sh


############ AFTERWARDS : ACME.SH #############

adduser acmeuser
usermod -a -G www-data acmeuser
su - acmeuser

cd /root
find /var/www/ -type f -print0 | xargs -0 chmod 0640
find /var/www/ -type d -print0 | xargs -0 chmod 0750
chmod -R 775 /var/www/letsencrypt
chmod -R 755 /etc/letsencrypt
chown -R www-data:www-data /var/www/
chown -R www-data:www-data /var/nc_data/
chmod 0644 /var/www/nextcloud/.htaccess
chmod 0644 /var/www/nextcloud/.user.ini
chmod 600 /etc/letsencrypt/rsa-certs/fullchain.pem
chmod 600 /etc/letsencrypt/rsa-certs/privkey.pem
chmod 600 /etc/letsencrypt/rsa-certs/chain.pem
chmod 600 /etc/letsencrypt/rsa-certs/cert.pem
chmod 600 /etc/letsencrypt/ecc-certs/fullchain.pem
chmod 600 /etc/letsencrypt/ecc-certs/privkey.pem
chmod 600 /etc/letsencrypt/ecc-certs/chain.pem
chmod 600 /etc/letsencrypt/ecc-certs/cert.pem
chmod 600 /etc/ssl/certs/dhparam.pem

sed -i '/ssl-cert-snakeoil/d' /etc/nginx/ssl.conf
sed -i s/\#\ssl/\ssl/g /etc/nginx/ssl.conf
systemctl restart nginx

exit
