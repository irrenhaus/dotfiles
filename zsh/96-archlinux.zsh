#!/bin/sh

######################### ArchLinux

function pacman-remove-orphans() {
	sudo pacman -Rns "$(pacman -Qtdq)"
}

if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi
