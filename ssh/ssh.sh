#!/bin/bash
sudo apt update -y
sudo apt install openssh-server
sudo systemctl status ssh
cd /etc/ssh
sudo rm sshd_config
sudo wget 








sudo systemctl start ssh

