#!/bin/bash

sudo apt update -y
sudo apt install wget curl -y
curl -sSL https://get.docker.com/ | CHANNEL=stable bash


sudo ufw allow 80/tcp # if you have ufw installed/enabled
sudo ufw allow 59000:59100/udp
wget https://raw.githubusercontent.com/nurdism/neko/master/.examples/simple/docker-compose.yaml
nano docker-compose.yaml # edit the passwords

sudo apt install docker-compose -y
sudo apt upgrade -y

sudo apt install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-pulseaudio xclip libxtst6 -y

sudo docker-compose up -d
