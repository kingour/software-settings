#!/usr/bin/env bash

# dir var
wd=$(cd `dirname ${0}` && pwd)
export MAIN_DIR=$(cd "${wd}/../" && pwd)

export CONF_DIR=${MAIN_DIR}/conf
export DOC_DIR=${MAIN_DIR}/doc
export LIB_DIR=${MAIN_DIR}/lib
export BIN_DIR=${MAIN_DIR}/bin

# base functions
function log() {
    local msg=""
    local i=1
    for((; i <= $#; i++));do
        arg=`eval echo \$\{${i}\}`
        msg="${msg} ${arg}"
    done
    echo "[$(date +%F' '%T)] INFO -- ${msg}"
}

# base ssh
function _ssh() {
    local _user=${1}
    local _host=${2}
    local _cmd=${3}
    ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no ${_user}@${_host} "${_cmd}"
}

# batch ssh
function batch_ssh() {
    local _user=$1
    local _hosts=$2
    local _cmd=$3
    log "batch ssh..."
    for host in `cat ${_hosts} | awk '{print $1}'`;do
        _ssh ${_user} ${host} "${_cmd}"
    done
}

function check_cronolog() {
    if [[ -f /usr/sbin/cronolog ]];then
        exit 0
    fi
    centos_ver=`cat /etc/redhat-release | grep -o "[0-9]\+.[0-9]\+" | awk -F. '{print $1}' | head -1`
    wget http://ftp.sjtu.edu.cn/fedora/epel/epel-release-latest-${centos_ver}.noarch.rpm -O /tmp/epel-release-latest-${centos_ver}.noarch.rpm
    rpm -Uvh /tmp/epel-release-latest-${centos_ver}.noarch.rpm
    rm -rf /tmp/epel-release-latest-${centos_ver}.noarch.rpm
    yum install -y cronolog
}

