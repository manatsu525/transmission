#!/bin/bash

apt update -y
apt install transmission-daemon -y
systemctl stop transmission-daemon
sed -i 's/\("rpc-password": \)".*"/\1"sumire"/g' /etc/transmission-daemon/settings.json
sed -i 's/\("rpc-username": \)".*"/\1"sumire"/g' /etc/transmission-daemon/settings.json
sed -i 's/\("rpc-whitelist-enabled": \).*/\1false,/g' /etc/transmission-daemon/settings.json
sed -i 's/\("rpc-authentication-required": \).*/\1true,/g' /etc/transmission-daemon/settings.json
sed -i 's/\("ratio-limit": \).*/\10.5,/g' /etc/transmission-daemon/settings.json
sed -i 's/\("rpc-port": \).*/\12095,/g' /etc/transmission-daemon/settings.json
sed -i 's/\("ratio-limit-enabled": \).*/\1true,/g' /etc/transmission-daemon/settings.json
systemctl start transmission-daemon

#/usr/local/etc/caddy/Caddyfile

sed -i '/proxy \/ http/{N;s/\n/ /;N;s/\n/ /};/proxy \/ http/c \    browse\n    root /usr/downloads' /etc/caddy/Caddyfile
ln -s /var/lib/transmission-daemon/downloads /usr/downloads
systemctl restart caddy
