#!/bin/bash
ip=x.x.x.x
screen=xxxx

/usr/bin/killall synergyc
sleep 1
echo 'synergyc started.....'
nohup /usr/bin/synergyc -n $screen --no-daemon $ip >> /dev/null 2>&1 &