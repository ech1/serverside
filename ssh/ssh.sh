#!/bin/bash
if [ "$EUID" -ne 0 ]
then
        echo 'MUST RUN AS ROOT!'
        exit
fi

apt update -y
apt install openssh-server rsync -y
systemctl status ssh
cd /etc/ssh
rm sshd_config
wget https://raw.githubusercontent.com/ech1/serverside/master/ssh/sshd_config
systemctl restart ssh

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

systemctl status sshd
ip a | grep inet

echo '[+] ON A REMOTE HOST RUN THE FOLLOWING:'
echo '[+] wget http://ip:8080/id25519 -O ~/.ssh/node.pkey'
echo '[+] chmod 600 ~/.ssh/node.pkey'
cd ~/.ssh/

python3 -m http.server 8080


