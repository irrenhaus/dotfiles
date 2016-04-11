#!/bin/bash

(cd $HOME/.vim && git submodule init && git submodule update)
mkdir -p $HOME/.config

echo "  Don't forget to install the dependencies. After that, open vim and run :BundleInstall! For your convenience, here is a all-in-one command:"
cat $HOME/.vim/README.install.md
