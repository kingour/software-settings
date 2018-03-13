#!/bin/bash
server_ip=x.x.x.x
server_port=xxxx
password="xxxx"

nohup sslocal -s $server_ip -p $server_port -l 1080 -k $password -t 600 -m aes-256-cfb &