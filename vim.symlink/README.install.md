```
sudo apt-get install astyle python-autopep8 tidy build-essential cmake python-dev exuberant-ctags python-pip silversearcher-ag libffi6 libffi-dev vim xdg-utils exuberant-ctags && \
sudo apt-get remove libgit2-dev && \
(cd /tmp && curl -L -O "https://github.com/libgit2/libgit2/archive/v0.22.0.tar.gz" && tar xf v0.22.0.tar.gz && cd libgit2-0.22.0 && mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && make && sudo make install) && \
sudo pip install cffi && \
sudo pip install mercurial psutil pygit2 && \
gem install pygments.rb redcarpet && \
sudo npm -g install instant-markdown-d js-beautify && \
(cd ~/.vim && git submodule init && git submodule update) && \
vim -c ":BundleInstall" -c ":qa" && \
(cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer --omnisharp-completer) && \
(cd ~/.vim/bundle/vimproc.vim && make) && \
grep -q -F "fields=+l" ~/.ctags || echo "--fields=+l" >> ~/.ctags
```

