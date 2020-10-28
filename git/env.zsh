for D in `find "$HOME/.dotfiles/git/" -maxdepth 1 -type d`; do
    if [ -e "$D/bin" ]; then
        export PATH="$PATH:$D/bin"
    else
        export PATH="$PATH:$D"
    fi
done
