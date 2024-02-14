#!/bin/bash

set -e

BASEDIR=$(realpath $(dirname $0))
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m'

log_head () {
  echo "$BOLD ### $@ ###$NORMAL"
}

log_err () {
  echo -e "$BOLD$RED$@$NC$NORMAL"
}

log_info () {
  echo -e "$BLUE$@$NC"
}

log_action() {
  echo -e "$BOLD$CYAN$@$NC$NORMAL"
}

log_head "Figuring OS"
if [ -f "/etc/os-release" ]; then
  source /etc/os-release
  log_info "found $ID"
else
  log_err "no /etc/os-release found. exit."
  exit 1
fi

log_head "Install packages"
if [ "$ID" == "arch" ]; then
  YAY_VERSION=$(yay --version)
  if [ "$?" != "0" ]; then
    log_action "setting up yay"
    cd $(mktemp -d)
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
  fi
  PACKAGES=(
    "fzf"
    "lazygit" 
    "neovim" 
    "ttf-hack-nerd" 
    "ripgrep" 
    "terminator" 
    "the_silver_searcher" 
    "zsh" 
    "bash-language-server"
  )
  for P in "${PACKAGES[@]}"; do
    yay -Qi "$P" > /dev/null && NEED=0 || NEED=1
    if [ $NEED == 1 ]; then
      log_action "install $P"
      yay -Sy --needed "$P"
    fi
  done
elif [ "$ID" == "ubuntu" ]; then
  PACKAGES=(
    "fzf"
    #"lazygit" TODO: check how to install
    #"neovim" TODO: snap
    #"ttf-hack-nerd" TODO: check how to install
    "ripgrep" 
    "terminator" 
    "silversearcher-ag" 
    "zsh" 
    #"bash-language-server" TODO: snap
  )
  for P in "${PACKAGES[@]}"; do
    dpkg -S "$P" > /dev/null && NEED=0 || NEED=1
    if [ $NEED == 1 ]; then
      log_action "install $P"
      sudo apt install "$P"
    fi
  done
else 
  log_err "OS '$ID' unsupported. skip."
fi

log_head "Linking dotfiles"
LINKS=(
  ".agignore"
  ".config/nvim"
  ".config/terminator/config"
  ".local/bin/upgrade-all"
  ".env"
  ".oh-my-zsh/custom/themes/cpt_foobar.zsh-theme"
  ".zsh_aliases"
  ".zshrc"
)
for LINK in "${LINKS[@]}"; do
  TARGET="$BASEDIR/home/$LINK"
  LINK_NAME="$HOME/$LINK"
  if [ -L "$LINK_NAME" ]; then
    log_info "link $LINK exists"
  elif [ -f "$LINK_NAME" ]; then
    log_err "will not link '$LINK': is a file."
    exit 1
  else
    log_action "create link $LINK"
    mkdir -p $(dirname $LINK_NAME)
    ln -sf "$TARGET" "$LINK_NAME"
  fi
done

log_head "Use zsh"
if [[ "$(echo $SHELL)" != */zsh ]]; then
  log_action "changing shell"
  chsh -s /usr/bin/zsh
fi

