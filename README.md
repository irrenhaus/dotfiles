dotfiles
========

Idea, installer & some code (esp. bin folder) shamelessly stolen from https://github.com/holman/dotfiles. Thanks for the great dotfiles config!

oh-my-zsh-custom
================

plugins/autovirtualenv
----------------------

Automatically detect Python virtualenvs by searching for their bin/activate scripts upon the change of a directory.
If such a script is found, the virtualenv is automatically activated (and a message is shown to you). The environment stays activated
until you leave the main directory (so within any sub-folders the environment stays activated).

If you leave the base folder the environment gets disabled and a message is shown to you.

Example:
```
╭irrenhaus > ~
╰> cd envtest 
Found virtualenv. Activating...
╭irrenhaus > ~/envtest [test]
╰> cd ..
Deactivating virtualenv: /home/irrenhaus/envtest/test
╭irrenhaus > ~
╰> 
```

Notice how the environment's name is displayed within the prompt. You can do that by using the supplied current_virtual_env() method which
returns a string like "[name]".

plugins/virtualpath
-------------------

This plugin looks for a file named ".virtualpath.conf" within the current directory upon each directory change.
If the file is found each line within the file is appended to the PATH variable until you leave the directory (that is including
subdirectories, so as soon as you change to _any_ different folder the PATH variable is reset).
This enables you to have per-directory custom PATH entries.

Example:
```
╭irrenhaus > ~
╰> cd pathtest 
Adding virtualpath /home/irrenhaus/bin to the PATH variable.
╭irrenhaus > ~/pathtest
╰> cat .virtualpath.conf 
/home/irrenhaus/bin
╭irrenhaus > ~/pathtest
╰> cd ..
Resetting PATH variable
```

themes/irrenhaus-dual
---------------------

Well, my currently perferred custom theme, try it and use it if you like it.
Be aware, this theme uses two lines per command (you can see it in the examples above).
The theme includes a display for git repositories.


Vim configurations
==================

Installation
------------

* Start VIM
 * Run ":BundleInstall"
* If you have problems using the clipboard stuff, add to bashrc/zshrc:
 * alias vim='gvim -v'

Per-Plugin Stuff
----------------

* vim-autoformat
 * Install the code formatters
  * sudo apt-get install astyle python-autopep8 tidy
  * sudo npm install -g js-beautify
* YouCompleteMe
 * Install dependencies
  * sudo apt-get install build-essential cmake python-dev
  * cd ~/.vim/bundle/YouCompleteMe
  * ./install.sh --clang-completer
* TagBar
 * At least install exuberant-ctags
  * sudo apt-get install exuberant-ctags
* powerline
 * sudo apt-get remove libgit2-dev
 * cd /tmp && curl -L -O "https://github.com/libgit2/libgit2/archive/v0.21.0.tar.gz" && tar xf v0.21.0.tar.gz && cd libgit2-0.21.0 && mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && make && sudo make install
 * sudo pip install mercurial psutil cffi pygit2
 * ln -s ~/.vim/powerline ~/.config/powerline
 * Make sure you're using a powerline patched font!
* vimproc
 * cd ~/.vim/bundle/vimproc.vim
 * make
* unite.vim
 * Install the silversearcher-ag application

All-In-One Installation Commands
--------------------------------

See vim.symlink/README.install.md
