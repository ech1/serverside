#!/bin/bash
sudo apt update -y
sudo apt install nginx-full
sudo wget https://raw.githubusercontent.com/ech1/serverside/keepass/nginx.conf -O /etc/nginx/nginx.conf
