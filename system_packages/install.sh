#!/bin/bash -e

function install_yay {
    if [ -f /usr/bin/yay ]; then
        echo "yay already installed; skipping"
        return
    fi

    (cd /tmp && git clone https://aur.archlinux.org/yay.git && makepkg -si)
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
    $SUDO "pacman -S --noconfirm --needed base-devel sudo curl pv acpi lm_sensors python-pip"
    install_yay
    yay -S --noconfirm --needed diff-so-fancy fasd nvm ncdu noti the_silver_searcher entr bat prettyping fd fzf
    source /usr/share/nvm/init-nvm.sh
    nvm install 10
    nvm use 10
    npm install -g tldr
fi

