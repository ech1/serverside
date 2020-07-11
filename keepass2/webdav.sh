#!/bin/bash
sudo apt update -y
sudo apt install apache2 apache2-utils curl wget -y

sudo a2enmod dav
sudo a2enmod dav_fs

sudo mkdir /webdav
sudo mkdir /var/www/webdav
sudo chown -R www-data:www-data /var/www/

#then we have to edit the main virtual host config with root priv
#sudo nano /etc/apache2/sites-avaialable/000-default.conf
cd /etc/apache2/sites-available
sudo rm -rf 00*
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass2/000-default.conf

echo '[+] CREATING THE USER!  ENTER PASSWD'
sudo htdigest -c /etc/apache2/users.password webdav $USER
sudo chown www-data:www-data /etc/apache2/users.password

sudo a2enmod auth_digest
sudo systemctl apache2 restart

ip a | grep inet
#the url is http://<IP>/webdav
#or dav://<IP>/webdav
