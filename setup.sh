#!/bin/bash

set -e
set -x

BASEDIR=$(realpath $(dirname $0))

pacman -S zsh gvim awesome ttf-hack termite xscreensaver
chsh -s /usr/bin/zsh

FILES=".config/awesome \
        .config/termite \
        .env \
        .lynxrc \
        .oh-my-zsh \
        .vim/bundle/Vundle.vim \
        .vimrc \
        .zsh_aliases \
        .zshrc"

for FILE in $FILES; do
    echo "ln -s $BASEDIR/$FILE ~/$FILE"
done
