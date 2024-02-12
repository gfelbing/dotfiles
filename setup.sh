#!/bin/bash

set -ex

BASEDIR=$(realpath $(dirname $0))

ensure_install() {
    APP=$1
    if [ -z "$(which $APP)" ]; then
        sudo pacman -S $APP
    fi
}

ensure_yay() {
    YAY_VERSION=$(yay --version)
    if [ "$?" == "0" ]; then
        echo "Already installed: '$YAY_VERSION', skipping."
        return
    fi
    cd $(mktemp -d)
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

install_deps() {
    yay -Sy --needed \
        dmenu \
        fzf \
        lazygit \
        neovim \
        nerd-fonts-hack \
        openssh \
        the_silver_searcher \
        terminator \
        zsh 
}

create_links() {
    for LINK in $@; do
        TARGET="$BASEDIR/home/$LINK"
        LINK_NAME="$HOME/$LINK"
        if [ ! -L "$LINK_NAME" ]; then
            ln -sf "$TARGET" "$LINK_NAME"
        fi
    done
}

create_all_links() {
    create_links \
        .config/nvim \
        .oh-my-zsh/custom/themes/cpt_foobar.zsh-theme \
        .agignore \
        .env \
        .zsh_aliases \
        .zshrc
}

ensure_yay
install_deps
create_all_links

if [[ "$(echo $SHELL)" != */zsh ]]; then
    chsh -s /usr/bin/zsh
fi

