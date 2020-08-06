#!/bin/bash

cd /usr/local/src && apt install wget -y
echo 'Pick :'
echo '1) Debian'
echo '2) Ubuntu'

read choice

if [ $choice -eq "1" ];
then
	wget debian_install.sh
else
	wget ubuntu_install.sh
fi
