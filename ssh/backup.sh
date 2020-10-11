#!/bin/bash
#this must run as root !
if [ "$EUID" -ne 0 ]
then
        echo 'MUST RUN AS ROOT!'
        exit
fi

cd /var/www/nextcloud/data/nothing/files/

#faut le run a 3AM
cooldate=$(date --iso-8601)
echo $cooldate

rm backup*.zip
rm backup-$cooldate.zip
zip -r backup-$cooldate.zip /var/www/nextcloud/data/nothing/files/
rsync backup-$cooldate.zip nothing@192.168.0.18:/home/nothing/backup/
rm backup*.zip

#crontab -e
#0 3 * * * /bin/bash /var/www/nextcloud/data/nothing/files/backup.sh

#chmod u+x backup.sh

#BACKUP_SERVER (192.168.0.18)
#https://github.com/ech1/serverside/blob/master/ssh/ssh.sh
#https://github.com/ech1/serverside/blob/master/ssh/ssh_arch.sh
