#!/bin/bash

(cd ~/.vim && git submodule init && git submodule update)
mkdir -p ~/.config

echo "  Don't forget to install the dependencies. After that, open vim and run :BundleInstall! For your convenience, here is a all-in-one command:"
cat ~/.vim/README.install.md
