which rbenv 1>/dev/null 2>/dev/null

if [ "$?" -eq "0" ]; then
    eval "$(rbenv init -)"
fi
