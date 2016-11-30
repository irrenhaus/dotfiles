for D in `find "$HOME/.dotfiles/git/" -type d -name "git-*"`; do
    if [ -e "$D/bin" ]; then
        export PATH="$PATH:$D/bin"
    else
        export PATH="$PATH:$D"
    fi
done
