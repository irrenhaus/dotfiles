#!/usr/bin/env bash

DOTFILES_ROOT="$HOME/.dotfiles"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

info "Setting up specifics for platform $(uname -s)"

if [ "$(uname -s)" == "Darwin" ]; then
  ln -s "$DOTFILES_ROOT/platform/Linux/Slic3r.symlink" "$HOME/Library/Application Support/Slic3r"
  if [ "$?" -eq "0" ]; then
    success 'Installed Slic3r configuration files'
  else
    fail 'Failed to install Slic3r configuration files'
  fi
fi
