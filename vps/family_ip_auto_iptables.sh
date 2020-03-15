#!/usr/bin/env bash

if [[ -z "${FAMILY_DDNS_HOST}" ]];then
    log "Pls set FAMILY_DDNS_HOST env param, like 'export FAMILY_DDNS_HOST=a.com'"
    exit 1
fi
if [[ -z "${USER_WHITELIST}" ]];then
    log "Pls set USER_WHITELIST env param, like 'export USER_WHITELIST=whitelist'"
    exit 1
fi
newip=$(nslookup "${FAMILY_DDNS_HOST}" | grep -A 1 "${FAMILY_DDNS_HOST}" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
oldip=$(iptables -L ${USER_WHITELIST} 1 | awk '{print $4}')
log "[HOST: ${FAMILY_DDNS_HOST}][oldip:${oldip}, newip:${newip}]"

if [[ x"${newip}" != x"${oldip}" ]];then
    log "replace first ip"
    mkdir -p /root/dev/iptables
    /bin/cp -f /etc/sysconfig/iptables /root/dev/iptables/iptables.$(date +%Y%m%d)
    iptables -R ${USER_WHITELIST} 1 -s ${newip} -j ACCEPT
    serive iptables save
fi