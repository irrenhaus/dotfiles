#####################
## Aliases
#####################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias lh='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Provide sort-by-size for du
alias du-sort='du -sh * | sort -h'

alias reinit='reset; source ~/.zshrc'

# We only want to use gvim if we're not on a remote server!
if [[ "x$SSH_CONNECTION" == "x" ]] && [[ "x$SSH_CLIENT" == "x" ]]; then
    alias vim='gvim -v'
fi

alias md5='md5sum'

# alias ls='exa -g'
# alias ll='exa -lg'
# alias lt='exa -lgTR'

alias vim='nvim'

# Mosh into a server and automatically resume / start a tmux session
alias tmosh='() {mosh $* -- sh -c "tmux a || tmux"}'

alias nvidia-settings='optirun -b none nvidia-settings -c :8'

alias staging-logs="multitail -l 'ssh deploy@api1.staging.zenmate.io \"tail -f /home/deploy/zenguard-api-v2/current/log/staging.log\"' -l 'ssh deploy@api2.staging.zenmate.io \"tail -f /home/deploy/zenguard-api-v2/current/log/staging.log\"'"

alias btr-todo='find -type d -name "btr" -exec grep -rn -C2 --color=always "TODO:" {} \;'

alias top='glances'
alias htop='glances'
