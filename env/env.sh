#!/usr/bin/env bash

# dir var
wd=$(cd `dirname ${0}` && pwd)
. ${wd}/../lib/*.sh

log "begin to custom .bashrc..."

# config bahshrc
if [[ x"`cat ~/.bashrc | grep 'TIME_STYLE'`" = x"" ]];then
    echo "export TIME_STYLE=long-iso" >> ~/.bashrc
fi
if [[ x"`cat ~/.bashrc | grep 'alias ll='`" = x"" ]];then
    echo "alias ll='ls -al -h --color=auto'" >> ~/.bashrc
fi
if [[ x"`cat ~/.bashrc | grep 'psgrep'`" = x"" ]];then
    echo "alias psgrep='ps aux | grep'" >> ~/.bashrc
fi
if [[ x"`grep "ulimit" ~/.bashrc`" = x"" ]];then
    echo "ulimit -c unlimited" >> ~/.bashrc
fi
if [[ x"`grep "HISTTIMEFORMAT" ~/.bashrc`" = x"" ]];then
    export HISTTIMEFORMAT='%F %T '
fi
if [[ x"`cat ~/.bashrc | grep 'color_my_prompt'`" = x"" ]];then
cat <<EOF >> ~/.bashrc
function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='\`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\\\\\\*\ \(.+\)$/\(\\\\\\\\\\1\)\ /\`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="\$__user_and_host \$__cur_location \$__git_branch_color\$__git_branch\$__prompt_tail\$__last_color "
}
color_my_prompt
EOF
fi

# config vim
log "config vim..."
/bin/cp -f ${MAIN_DIR}/vim/vimrc ~/.vimrc

# install needed
log "yum install needed..."
sudo yum -y install epel-release && sudo yum -y install lrzsz iotop htop lsof iftop git telnet wget gcc

# config apply
log "apply config"
source ~/.bashrc