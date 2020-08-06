#!/bin/bash
curl https://get.acme.sh | sh

mkdir -p /var/www/letsencrypt/.well-known/acme-challenge /etc/letsencrypt/rsa-certs /etc/letsencrypt/ecc-certs
chmod -R 775 /var/www/letsencrypt /etc/letsencrypt && chown -R www-data:www-data /var/www/ /etc/letsencrypt

var=1
while [ $var -eq 1 ];
do
        echo 'enter your domain'
        read domain
        echo 'Are you sure ? (y/n)'
        read choice
        if [[ $choice == "y" ]];
        then
                var=0
        fi
done
echo $domain

acme.sh --issue -d $domain --keylength 4096 -w /var/www/letsencrypt --key-file /etc/letsencrypt/rsa-certs/privkey.pem --ca-file /etc/letsencrypt/rsa-certs/chain.pem --cert-file /etc/letsencrypt/rsa-certs/cert.pem --fullchain-file /etc/letsencrypt/rsa-certs/fullchain.pem
acme.sh --issue -d $domain --keylength ec-384 -w /var/www/letsencrypt --key-file /etc/letsencrypt/ecc-certs/privkey.pem --ca-file /etc/letsencrypt/ecc-certs/chain.pem --cert-file /etc/letsencrypt/ecc-certs/cert.pem --fullchain-file /etc/letsencrypt/ecc-certs/fullchain.pem

cd /root
find /var/www/ -type f -print0 | xargs -0 chmod 0640
find /var/www/ -type d -print0 | xargs -0 chmod 0750
chmod -R 775 /var/www/letsencrypt
chmod -R 755 /etc/letsencrypt
chown -R www-data:www-data /var/www/
chown -R www-data:www-data /var/nc_data/
chmod 0644 /var/www/nextcloud/.htaccess
chmod 0644 /var/www/nextcloud/.user.ini
chmod 600 /etc/letsencrypt/rsa-certs/fullchain.pem
chmod 600 /etc/letsencrypt/rsa-certs/privkey.pem
chmod 600 /etc/letsencrypt/rsa-certs/chain.pem
chmod 600 /etc/letsencrypt/rsa-certs/cert.pem
chmod 600 /etc/letsencrypt/ecc-certs/fullchain.pem
chmod 600 /etc/letsencrypt/ecc-certs/privkey.pem
chmod 600 /etc/letsencrypt/ecc-certs/chain.pem
chmod 600 /etc/letsencrypt/ecc-certs/cert.pem
chmod 600 /etc/ssl/certs/dhparam.pem

sed -i '/ssl-cert-snakeoil/d' /etc/nginx/ssl.conf
sed -i s/\#\ssl/\ssl/g /etc/nginx/ssl.conf
service nginx restart

exit
