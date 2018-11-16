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

# Provide sort-by-size for du
alias du-sort='du -sh * | sort -h'

alias reinit='exec zsh -l'

# We only want to use gvim if we're not on a remote server!
if [[ "x$SSH_CONNECTION" == "x" ]] && [[ "x$SSH_CLIENT" == "x" ]]; then
    alias vim='gvim -v'
fi

alias md5='md5sum'

alias vim='nvim'

alias top='glances'
alias htop='glances'

alias find='echo "Nope, use fd or fzf instead!"'
alias ping='prettyping'

########################## DOCKER

# Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'

# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'

# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'

# Delete all tangling volumes.
alias dockercleanv='printf "\n>>> Deleting dangling volumes\n\n" && docker volume rm $(docker volume ls -qf dangling=true)'

# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani || true && dockercleanv'

alias dockerremovealli='docker rmi $(docker images -q)'



######################### emacs

alias em="emacsclient -a '' -c -n"

alias open='xdg-open'

alias raspberry-scan="sudo nmap -sP 192.168.178.0/24 | awk '/^Nmap/{ip=\$NF}/B8:27:EB/{print ip}'"
