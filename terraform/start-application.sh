#!/bin/bash

cat <<EOT >> myapp.service
[Unit]
Description=MyAPP service
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/application
ExecStart=node /home/ubuntu/application/myapp.js
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=[MyAPP]
RestartSec=10

[Install]
WantedBy=multi-user.target
EOT

sudo cp api.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start api

#until tail /var/log/syslog | grep 'node /home/ubuntu/application/myapp.js' > /dev/null; do sleep 5; done
