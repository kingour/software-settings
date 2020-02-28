#!/usr/bin/env bash

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -y
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="ys"/' ~/.zshrc
sed -i 's/^# HIST_STAMPS=.*/HIST_STAMPS="%F %T"/' ~/.zshrc
sed -i 's/^plugins=.*/plugins=(\n\tgit\n\tzsh-syntax-highlighting\n\t\zsh-autosuggestions\n\thistory-substring-search\n\tz\n\textract\n\t)/' ~/.zshrc
sed -i 's/^# export LANG=.*/export LANG=en_US.UTF-8/' ~/.zshrc

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install -y

cat <<EOF >> ~/.zshrc
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -al -h --color=auto'
alias psgrep='ps aux | grep'
ulimit -c unlimited
EOF

chsh -s $(which zsh)