#!/bin/bash
sudo apt update -y
sudo apt install openssh-server
sudo systemctl status ssh
cd /etc/ssh
sudo rm sshd_config
sudo wget https://raw.githubusercontent.com/ech1/serverside/master/ssh/sshd_config
sudo systemctl reload ssh

#WE ARE ON THE SERVER !!!
#So we generate the public ssh key
cd ~/.ssh/
ssh-keygen -t ed25519
cat id_ed25519.pub >> authorized_keys

#ssh server has the public key
#we give the private key to the user somehow
#the user puts id_ed25519 into his own ~/.ssh/
#and only after he can login




sudo systemctl start ssh

