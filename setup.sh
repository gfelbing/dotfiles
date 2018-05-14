#!/bin/bash

set -e
set -x

BASEDIR=$(realpath $(dirname $0))

ensure_install() {
    APP=$1
    if [ -z "$(which $APP)" ]; then
        sudo pacman -S $APP
    fi
}

ensure_install ansible
ansible-playbook -v --ask-become-pass "$BASEDIR/playbook.yaml"

# TODO: move this to playbook
if [[ "$(echo $SHELL)" != */zsh ]]; then
    chsh -s /usr/bin/zsh
fi

