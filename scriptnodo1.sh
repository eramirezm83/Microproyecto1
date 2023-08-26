#!/bin/bash
#apt-get update
# base
#apt-get install --yes python nginx postgresql postgresql-client -y redis-server
# others#
#apt-get install --yes curl tmux htop

# some additional configuration here

echo "Configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install consul
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo npm install consul -g
sudo npm install express -g

echo "Ejcutando el consul"
sudo consul agent -ui=false -bind=192.168.100.8 -client=0.0.0.0 -data-dir=. -node=nodo1 -retry-join="192.168.100.3" -retry-join="192.168.100.2" -retry-join="192.168.100.8" &

echo "Instalando un servidor vsftpd"
sudo apt-get install vsftpd -y 

echo "Modificando vsftpd.conf con sed"
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf

echo "Configurando ip forwarding  con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf 

echo "Activando firewall"
apt update && apt upgrade
ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp

echo "intalando LXD"
sudo apt-get install lxd-installer -y
newgrp lxd
lxd init --auto

sudo git clone https://github.com/omondragon/consulService

echo "lazando el servicio"

#sudo node consulService/app/index.js 5004 &






































































