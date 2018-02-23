#!/bin/bash

set -e
set -x

BASEDIR=$(realpath $(dirname $0))

sudo pacman -S zsh gvim awesome ttf-hack termite xscreensaver
chsh -s /usr/bin/zsh

FILES=".config/awesome \
        .config/termite \
        .config/base16-shell \
        .env \
        .lynxrc \
        .oh-my-zsh \
        .vim/bundle/Vundle.vim \
        .vimrc \
        .zsh_aliases \
        .zshrc"

for FILE in $FILES; do
    echo "ln -fs $BASEDIR/$FILE ~/$FILE"
done
