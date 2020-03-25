#!/usr/bin/env bash

# dir var
wd=$(cd `dirname ${0}` && pwd)
. ${wd}/../lib/*.sh

. /root/.bashrc
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin:$PATH

if [[ -z "${FAMILY_DDNS_HOST}" ]];then
    log "Pls set FAMILY_DDNS_HOST env param, like 'export FAMILY_DDNS_HOST=a.com'"
    exit 1
fi
if [[ -z "${USER_WHITELIST}" ]];then
    log "Pls set USER_WHITELIST env param, like 'export USER_WHITELIST=whitelist'"
    exit 1
fi
newip=$(nslookup "${FAMILY_DDNS_HOST}" | grep -A 1 "${FAMILY_DDNS_HOST}" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
oldip=$(/sbin/iptables -nvL ${USER_WHITELIST} 1 | awk '{print $8}')
log "[HOST: ${FAMILY_DDNS_HOST}][oldip:${oldip}, newip:${newip}]"

chain_flag=$(/sbin/iptables -S ${USER_WHITELIST} | grep "\-N" | wc -l)
if [[ ${chain_flag} -eq 0 ]];then
    /sbin/iptables -N ${USER_WHITELIST}
fi

if [[ x"${newip}" != x"${oldip}" ]];then
    log "replace first ip"
    mkdir -p /root/dev/iptables
    /bin/cp -f /etc/sysconfig/iptables /root/dev/iptables/iptables.$(date +%Y%m%d)
    /sbin/iptables -R ${USER_WHITELIST} 1 -s ${newip} -j ACCEPT
    /usr/sbin/service iptables save
fi
