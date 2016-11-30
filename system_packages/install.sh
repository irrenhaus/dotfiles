#!/bin/bash -e

function install_yaourt {
    if [ -f /usr/bin/yaourt ]; then
        echo "yaourt already installed; skipping"
        return
    fi

    $(cd /tmp &&\
        curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz &&\
        tar -xvzf package-query.tar.gz &&\
        cd package-query &&\
        sudo makepkg -si)

    $(cd /tmp &&\
        curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz &&\
        tar -xvzf yaourt.tar.gz &&\
        cd yaourt &&\
        sudo makepkg -si)
}

if [ -f /etc/debian_version ]; then
    # We're on debian
    echo "Installing Debian packages"
fi

if [ -f /etc/arch-release ]; then
    # Wohoo, ArchLinux!
    echo "Installing ArchLinux packages"
    SUDO="su -c"
    if [ -f /usr/bin/sudo ]; then
        SUDO="sudo bash -c"
    fi
    $SUDO "pacman -S --noconfirm base-devel sudo curl diff-so-fancy pv"
    install_yaourt
    yaourt -S fasd watchman python2-pywatchman
    sudo pip install git-sweep
fi

