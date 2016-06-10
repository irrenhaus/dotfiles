```
sudo add-apt-repository ppa:neovim-ppa/unstable && \
sudo apt-get update && \
sudo apt-get install neovim && \
sudo apt-get install astyle python-autopep8 tidy build-essential cmake python-dev exuberant-ctags python-pip silversearcher-ag libffi6 libffi-dev vim xdg-utils exuberant-ctags python-dev python-pip python3-dev python3-pip libgit2-24 libgit2-dev && \
sudo pip3 install neovim && \
sudo pip install cffi && \
sudo pip install mercurial psutil pygit2 && \
npm -g install js-beautify && \
(cd ~/.vim && git submodule init && git submodule update) && \
nvim -c ":PlugInstall" -c ":UpdateRemotePlugins" -c ":qa"
```


(cd /tmp && curl -L -O "https://github.com/libgit2/libgit2/archive/v0.24.1.tar.gz" && tar xf v0.24.1.tar.gz && cd libgit2-0.24.1 && mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && make && sudo make install) && \
sudo apt-get remove libgit2-dev && \
