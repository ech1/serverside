#!/bin/bash
#this must run as root !
if [ "$EUID" -ne 0 ]
then
	echo 'MUST RUN AS ROOT!'
	exit
fi

zip -r backup.zip /var/snap/nextcloud/common/nextcloud/data/nothing/files/
cp id_ed25519 ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
scp backup.zip nothing@192.168.0.18:/home/nothing/backup.zip

