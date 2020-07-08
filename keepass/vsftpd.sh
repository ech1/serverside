#!/bin/bash
echo '[+] Setting up your KeePass Server'
sudo apt update -y
sudo apt upgrade -y
sudo apt install vsftpd wget curl
sudo systemctl stop vsftpd
sudo cd /etc
sudo rm vsftpd.conf
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass/vsftpd.conf
sudo systemctl start vstfpd
sudo systemctl enable vsftpd
echo '[+] FINISHED, you can connect to the following ip :'
ip addr | cut -d ' ' -f 6
curl https://ifconfig.me
echo '[+] on port 21 !'
