#!/bin/bash
sudo apt update -y
sudo apt install nginx -y

curl link/nginx.conf > /etc/nginx/nginx.conf

sudo systemctl enable nginx
sudo systemctl restart nginx
sudo nginx -t
