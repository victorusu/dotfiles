#!/bin/bash

if [ -d ${HOME}/.dotfiles ]; then
    echo "Cannot proceed ${HOME}/.dotfiles folder already exist"
    exit 1
fi

pkg_manager() {
    tools=(zypper dnf apt)
    for t in ${tools[@]}; do
        which ${t} >& /dev/null
        if [ $? -eq 0 ]; then
            break
        fi
    done
    echo $t
    unset $t
}

sudo_cmd() {
    if [ $(id -u) -eq 0 ]; then
        echo ""
    else
        CMD=$(which $1 2> /dev/null)
        if [ $? -ne 0 ]; then
            echo "Cannot proceed $1 cmd not found"
            exit 1
        fi
        echo $CMD
        unset CMD
    fi
}

get_cmd_or_install() {
    set -e
    CMD=$(which $1 2> /dev/null)
    if [ $? -ne 0 ]; then
        ${SUDOCMD} ${MGMT} install -y $1
    fi
    echo $CMD
    unset CMD
}

echo "checking package manager... "
MGMT=$(pkg_manager)
echo ${MGMT}

echo "checking sudo cmd... "
SUDOCMD=$(sudo_cmd sudo)
echo "found ${SUDOCMD}"

echo "checking if git is installed, if not install it... "
GITCMD=$(get_cmd_or_install git)
echo "found ${GITCMD}"

echo "checking if stow is installed, if not install it... "
STOWCMD=$(get_cmd_or_install stow)
echo "found ${STOWCMD}"


cd
${GITCMD} clone https://github.com/victorusu/dotfiles .dotfiles
cd .dotfiles
${STOWCMD} --dotfiles --adopt -t ~/ bash
${GITCMD} restore bash
${STOWCMD} --dotfiles -t ~/ vim
exit 0
