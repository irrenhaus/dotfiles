function debug {
    if [[ "$DOTFILE_DEBUG" == "true" ]]; then
        echo $@ >> /tmp/dotfile.log
    fi
}

function update_dotfile_config_files {
    DOT=${DOTFILES:=~/.dotfiles}

    find $DOT -maxdepth 2 -name "*.zsh" -not -name "dotfunctions.zsh" > $DOT/.config_files
}

function dotfile_config_files {
    if [ -z "$DOTFILE_CONFIG_FILES" ]; then
        if [ ! -f $DOTFILES/.config_files ]; then
            update_dotfile_config_files
        fi

        export DOTFILE_CONFIG_FILES=$(cat $DOTFILES/.config_files)
    fi
}

function set_debug_mode {
    if [[ -f "/tmp/dotfiles.debug" ]]; then
        export DOTFILE_DEBUG="true"

        echo "DEBUG enabled"
    else
        export DOTFILE_DEBUG="false"
    fi
}

function load_path_config {
    debug "Loading path config files..."

    for file in ${(M)${(@f)DOTFILE_CONFIG_FILES}:#*/path.zsh}; do
        debug "Processing path config $file..."

        if ! [[ "$file" =~ '.*\.symlink$' ]]; then
            debug "Loading path config: $file"
            source $file
        fi
    done
}

function load_env_config {
    debug "Loading env config files..."

    for file in ${(M)${(@f)DOTFILE_CONFIG_FILES}:#*/env.zsh}; do
        debug "Processing env config $file..."

        if ! [[ "$file" =~ '.*\.symlink$' ]]; then
            debug "Loading env config: $file"
            source $file
        fi
    done
}

function load_general_config {
    debug "Loading general config files..."

    local -a generals
    generals=(${(f)DOTFILE_CONFIG_FILES})
    generals=(${generals#*/path.zsh})
    generals=(${generals#*/completion.zsh})
    generals=(${generals#*/aliases.zsh})
    generals=(${generals#*/env.zsh})

    for file in $generals; do
        debug "Processing general config $file..."

        if ! [[ "$file" =~ '.*\.symlink$' ]]; then
            debug "Loading general config: $file"
            source $file
        fi
    done
}
