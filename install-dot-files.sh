#!/bin/bash

if [ -d ${HOME}/.dotfiles ]; then
    echo "Cannot proceed ${HOME}/.dotfiles folder already exist"
    exit 1
fi

tools=(zypper dnf apt)
for t in ${tools[@]}; do
    mgmt=${t}
    which ${mgmt} >& /dev/null
    if [ $? -eq 0 ]; then
        break
    fi
done

echo "using ${mgmt} tool"
SUDOCMD=$(which sudo)
if [ $? -ne 0 ]; then
    echo "Cannot proceed sudo cmd not found"
    exit 1
fi

${SUDOCMD} ${mgmt} install -y git stow

cd
git clone https://github.com/victorusu/dotfiles .dotfiles
cd .dotfiles
stow --dotfiles --adopt -t ~/ bash
git restore bash
stow --dotfiles -t ~/ vim
exit 0
