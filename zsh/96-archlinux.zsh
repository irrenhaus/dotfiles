#!/bin/sh

######################### ArchLinux

function pacman-remove-orphans() {
	sudo pacman -Rns "$(pacman -Qtdq)"
}
