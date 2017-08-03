#!/usr/bin/env bash
#
# Shamelessly ripped from https://github.com/holman/dotfiles/blob/master/script/bootstrap, thanks for the great dotfiles setup!
# Modified to my needs.

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

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $(basename "$src"), what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  export DOTPLATFORM="$1"
  export WORKINGDIR="$DOTFILES_ROOT"
  local overwrite_all=false backup_all=false skip_all=false

  (
    if [ -n "$DOTPLATFORM" ]; then
        WORKINGDIR="$WORKINGDIR/platform/$DOTPLATFORM"
        info "using platform $DOTPLATFORM"
    fi && \
    for src in $(find "$WORKINGDIR" -maxdepth 1 -name '*.symlink'); do
      filename="$(echo $src | sed 's/.symlink//g')"
      dst="$HOME/.$(basename "$filename")"
      link_file "$src" "$dst"
    done && \
    for src in $(find "$WORKINGDIR" -maxdepth 4 -name '*.symlink' -path '*.merge*' -not -path 'platform'); do
      dstpath=$(basename $(dirname $src))
      filename="$(echo $src | sed 's/.symlink//g')"
      dst="$HOME/.${dstpath%.*}/.$(basename "$filename")"
      link_file "$src" "$dst"
    done
  )
}

update_submodules () {
    (cd $DOTFILES_ROOT && git submodule init && git submodule update)
}

set -e

update_submodules
install_dotfiles
install_dotfiles "$(uname -s)"

if [ "x$NOINSTALL" != "xYes" ]; then
  if [ -f "platform/$(uname -s)/dependencies.sh" ]; then
    info "installing dependencies"

    if source "platform/$(uname -s)/dependencies.sh" > /tmp/dotfiles-dot 2>&1; then
      success "dependencies installed"
    else
      fail "error installing dependencies"
    fi
  fi

  echo '  Running installers...'
  for I in `find "$DOTFILES_ROOT" -maxdepth 2 -name "install.sh"`; do
    sh -c "$I"
  done
fi

echo ''
echo '  All installed!'
