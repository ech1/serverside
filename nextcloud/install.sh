#!/bin/bash

cd /usr/local/src && apt install wget -y
echo 'Pick :'
echo '1) Debian'
echo '2) Ubuntu'

read choice

if [ $choice -eq "1" ];
then
	wget https://raw.githubusercontent.com/ech1/serverside/master/nextcloud/debian_install.sh
	mv debian_install.sh install.sh
else
	wget https://raw.githubusercontent.com/ech1/serverside/master/nextcloud/ubuntu_install.sh
	mv ubuntu_install.sh install.sh
fi

sudo chmod +x install.sh
./install.sh


############ AFTERWARDS : ACME.SH #############

adduser acmeuser
usermod -a -G www-data acmeuser
su - acmeuser

exit

