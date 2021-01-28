#!/bin/bash

service(){
cat > qb.service <<-EOF
[Unit]
Description=qb(/etc/systemd/system/qb.service)
After=network.target
Wants=network-online.target
[Service]
Type=simple
User=root
ExecStart=/usr/bin/qbittorrent-nox --webui-port=2052
Restart=on-failure
RestartSec=10s
[Install]
WantedBy=multi-user.target
EOF
}

apt update -y
apt install qbittorrent-nox -y
service
mv qb.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable qb.service
systemctl start qb

mkdir /usr/downloads
sed -i '/proxy \/ http/{N;s/\n/ /;N;s/\n/ /};/proxy \/ http/c \    browse\n    root /usr/downloads' /usr/local/etc/caddy/Caddyfile
systemctl restart caddy
