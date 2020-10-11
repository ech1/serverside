#!/bin/sh

sudo pacman -Syu
sudo pacman -S openssh rsync
cd /etc/ssh
sudo rm sshd_config
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/ssh/sshd_config
sudo systemctl enable sshd --now
sudo systemctl status sshd

mkdir ~/.ssh/
cd ~/.ssh/

ssh-keygen -t ed25519
cat id_ed25519.pub >> authorized_keys


