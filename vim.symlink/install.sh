#!/bin/bash -e

(cd $HOME/.vim && git submodule init && git submodule update)

CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}

if [ ! -e $CONFIG_HOME/nvim ]; then
    ln -fs ~/.vim $XDG_CONFIG_HOME/nvim
fi

if [ ! -f $CONFIG_HOME/nvim/init.vim ]; then
    ln -fs ~/.vimrc $CONFIG_HOME/nvim/init.vim
fi

if [ -f /etc/debian_version ]; then
    # We're on debian
    echo "Installing Debian dependencies for vim"
    sudo add-apt-repository ppa:neovim-ppa/unstable && \
    sudo apt-get update && \
    sudo apt-get install neovim && \
    sudo apt-get install astyle python-autopep8 tidy build-essential cmake python-dev exuberant-ctags python-pip silversearcher-ag libffi6 libffi-dev vim xdg-utils exuberant-ctags python-dev python-pip python3-dev python3-pip libgit2-24 libgit2-dev && \
    sudo pip3 install neovim && \
    sudo pip install cffi && \
    sudo pip install mercurial psutil pygit2
fi

if [ -f /etc/arch-release ]; then
    # Wohoo, ArchLinux!
    echo "Installing ArchLinux dependencies for vim"
    sudo pacman -Sy --noconfirm autopep8 astyle tidy cmake ctags the_silver_searcher libffi xdg-utils python-cffi python-pygit2 python-psutil npm
fi

# case $(readlink -f .)/ in
#     $(readlink -f /home)/*) npm -g install js-beautify ;;
#     *) sudo npm -g install js-beautify ;;
# esac

cat $HOME/.vim/README.install.md
