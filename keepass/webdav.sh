#!/bin/bash
sudo apt update -y
sudo apt install nginx-full
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass/nginx.conf -O /etc/nginx/nginx.conf
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass/0-webdav.conf -O /etc/nginx/conf.d/0-webdav.conf
