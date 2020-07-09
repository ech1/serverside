#!/bin/bash
sudo apt update -y
sudo apt install nginx-full
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass/nginx.conf -O /etc/nginx/nginx.conf
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/keepass/0-webdav.conf -O /etc/nginx/conf.d/0-webdav.conf
echo -n "$USER:" | sudo tee /etc/nginx/.passwords.list
openssl passwd -apr1 | sudo tee -a /etc/nginx/.passwords.list
sudo nginx -t
sudo systemctl restart nginx
