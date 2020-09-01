sudo cp ./frps /usr/bin/
sudo mkdir -p /etc/frp
sudo cp ./frps.ini /etc/frp/

cat <<EOF | sudo tee /lib/systemd/system/frps.service
[Unit]
Description=Frp Server Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/usr/bin/frps -c /etc/frp/frps.ini

[Install]
WantedBy=multi-user.target
EOF

cat /lib/systemd/system/frps.service

sudo systemctl daemon-reload
sudo systemctl start frps
sudo systemctl enable frps
