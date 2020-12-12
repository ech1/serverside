#!/bin/bash
sudo apt update -y
sudo apt install openssh-server rsync
sudo systemctl status ssh
cd /etc/ssh
sudo rm sshd_config
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/ssh/sshd_config
sudo systemctl restart ssh

#WE ARE ON THE SERVER !!!
#So we generate the public ssh key
mkdir ~/.ssh/
cd ~/.ssh/
ssh-keygen -t ed25519
cat id_ed25519.pub >> authorized_keys

#ssh server has the public key
#we give the private key to the user somehow
#the user puts id_ed25519 into his own ~/.ssh/
#and he does "chmod 600 ~/.ssh/id_ed25519"
#and only after he can login

sudo systemctl restart ssh

