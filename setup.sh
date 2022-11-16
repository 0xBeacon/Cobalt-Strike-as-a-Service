#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


if [ "$EUID" -ne 0 ]
  then echo -e ${RED}[-] Run script as root${NC}
  exit
fi

echo -e ${YELLOW}[+]${NC} What is your Cobalt Strike TeamServer directory?
read directory

echo -e ${YELLOW}[+]${NC} What is the TeamServer listening IP?
read ip

echo -e ${YELLOW}[+]${NC} What is the TeamServer Password?
read passwd

echo -e ${YELLOW}[+]${NC} What is the path to your c2 profile?
read profile

echo -e ${YELLOW}[+]${NC} Does this TeamServer startup command look correct?
echo $directory/teamserver $ip $passwd $profile 
echo -e ${YELLOW}[+]${NC} Enter \(y/n\)
read response

if [[ $response = n ]] ; then
  echo -e ${RED}[-]${NC} Try again
  exit
fi

touch /etc/systemd/system/teamserver.service

cat << EOF > /etc/systemd/system/teamserver.service
[Unit]
Description=Cobalt Strike Team Server
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
WorkingDirectory=$directory
ExecStart=$directory/teamserver $ip $passwd $profile

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl status teamserver.service
systemctl start teamserver.service
systemctl status teamserver.service
systemctl enable teamserver.service
