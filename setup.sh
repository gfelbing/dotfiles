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
        ansible \
        awesome \
        chromium \
        dmenu \
        firefox \
        fzf \
        i3-wm  \
        i3blocks  \
        i3lock  \
        i3status \
        maim \
        neovim \
        nerd-fonts-hack \
        openssh \
        python-neovim \
        python-neovim \
        termite \
        the_silver_searcher \
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
        .config/awesome \
        .config/termite \
        .config/base16-shell \
        .config/i3 \
        .config/nvim/init.vim \
        .config/nvim/bundle/Vundle.vim \
        .local/bin/lock \
        .local/bin/telegram \
        .local/bin/riot \
        .agignore \
        .env \
        .lynxrc \
        .padlock.png \
        .oh-my-zsh \
        .zsh_aliases \
        .zshrc
}

ensure_yay
install_deps
create_all_links

if [[ "$(echo $SHELL)" != */zsh ]]; then
    chsh -s /usr/bin/zsh
fi

