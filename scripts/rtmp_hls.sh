#!/bin/bash

#once digitalocean ubuntu machine is setup
#run this script like so :
cd ~
sudo apt update -y && sudo apt upgrade -y
sudo apt-get install rtorrent build-essential libpcre3 libpcre3-dev libssl-dev zlib1g zlib1g-dev -y


#THE VERSION CAN CHANGE OVER TIME VISIT :
#http://nginx.org/en/download.html
wget http://nginx.org/download/nginx-1.16.1.tar.gz
tar -xf nginx-1.16.1.tar.gz
cd nginx-1.16.1
mkdir modules
cd modules
git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git
cd ..




NGINX_OPTIONS="
		--prefix=/etc/nginx \
		--sbin-path=/usr/sbin/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/run/nginx.lock \
		--user=www-data \
		--group=www-data \
		--with-cc-opt=-Wno-deprecated-declarations \
		--with-cc-opt=-Wno-ignored-qualifiers
		--with-threads \
		--with-file-aio \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_mp4_module \
		--with-http_auth_request_module \
		--with-http_slice_module \
		--with-http_stub_status_module \
		--with-http_realip_module \
		--with-http_sub_module \
		--add-module=modules/nginx-rtmp-module"

./configure $NGINX_OPTIONS
make -j $(nproc)
make install

strip -s /usr/sbin/nginx
mkdir -p /etc/nginx
mkdir -p /var/log/nginx

cd /lib/systemd/system/
wget https://raw.githubusercontent.com/Angristan/nginx-autoinstall/master/conf/nginx.service
systemctl daemon-reload
systemctl enable nginx

cd -

curl -sk https://raw.githubusercontent.com/ech1/serverside/scripts/swamp_cinema/nginx.conf > /etc/nginx/nginx.conf

#sudo nano /etc/nginx/nginx.conf
/usr/sbin/nginx -t
#test says OK then cool

#then it's just about making nginx run
systemctl start nginx
#to reload it:
#nginx -t && nginx -s reload

#to kill it :
#systemctl stop nginx

#load up obs : go to custom rtmp server
#then put rtmp://<IFCONFIG GREPPED OUT CUT>:1935/live
#put whatever as key
#then go in swamp cinema and queue http://<ifconfig>:8080/key
#config from https://stackoverflow.com/questions/34248149/connecting-obs-studio-to-nginx-server


# nano /etc/nginx/nginx.conf

cd /home
sudo mkdir swamp
cd swamp
sudo wget https://github.com/ech1/serverside/raw/master/scripts/swamp_cinema/test.mp4

echo
echo
echo
echo '###################################################################'
echo
echo 'OPEN OBS AND STREAM TO :'
echo 'rtmp://<ip>:1935/show'
echo 'put whatever key you want, here its "test"'
echo
echo 'http://<ip>/'
echo 'allows you to browse the mp4 files you put in /home/swamp'
echo
echo '###################################################################'
echo
echo 'once you have started streaming with obs, go queue in swamp cinema:'
echo 'http://<ip>:8080/hls/test.m3u8'
echo 'YOUR IP IS':
echo $(curl -sk ifconfig.me)
echo
echo '###################################################################'
