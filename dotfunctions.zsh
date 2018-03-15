function update_dotfile_config_files {
    DOT=${DOTFILES:=~/.dotfiles}

    typeset -U config_files
    config_files=("${(@f)$(find $DOT -maxdepth 2 -name "*.zsh" -not -name "dotfunctions.zsh")}")

    echo $config_files > $DOT/.config_files

    DOTFILE_CONFIG_FILES=$(cat $DOT/.config_files)
}

function dotfile_config_files {
    if [ ! -f $DOTFILES/.config_files ]; then
        update_dotfile_config_files
    fi

    echo $DOTFILE_CONFIG_FILES
}
