#!/usr/bin/env bash

# dir var
wd=$(cd `dirname ${0}` && pwd)
. ${wd}/../lib/*.sh

systemctl stop firewalld.service
systemctl disable firewalld.service

yum install -y iptabes iptables-services
systemctl enable iptables
systemctl enable ip6tables
serive iptables restart
serive ip6tables restart
iptables -nvL
ip6tables -nvL

hostnamectl set-hostname kingour-vps-zepto