sudo cp ./frpc /usr/bin/
sudo mkdir -p /etc/frp
sudo cp ./frpc.ini /etc/frp/

cat <<EOF | sudo tee /lib/systemd/system/frpc.service
[Unit]
Description=Frp Client Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/usr/bin/frpc -c /etc/frp/frpc.ini
ExecReload=/usr/bin/frpc reload -c /etc/frp/frpc.ini

[Install]
WantedBy=multi-user.target
EOF

cat /lib/systemd/system/frpc.service

sudo systemctl daemon-reload
sudo systemctl start frpc
sudo systemctl enable frpc
