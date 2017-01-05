VENV_DETECTION_RESTRICT_TO="$HOME" # Only detect if within this directory root

autoload -U add-zsh-hook

autodetect_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        local basedir=$(bash -c "cd ${VIRTUAL_ENV}/.. && pwd")
        if [[ ! $PWD/ = $basedir/* ]]; then
            echo "Deactivating virtualenv: $VIRTUAL_ENV"
            deactivate
        fi
    else
        setopt | grep "nonomatch" > /dev/null
        local nomatchopt="$?"

        if [ "$nomatchopt" -eq "1" ]; then
            unsetopt nomatch
        fi

        local current_path=`pwd`
        local activatescripts=""
        while [ "$current_path" != "/" ]; do
            # Check if the current path still contains the VENV_DETECTION_RESTRICT_TO path
            if [ "${current_path#*$VENV_DETECTION_RESTRICT_TO}" == "$current_path" ]; then
                break
            fi

            activatescripts="$(/bin/ls $current_path/*env*/bin/activate $current_path/*env*/bin/activate.csh 2>/dev/null)"
            activatescripts=($activatescripts)
            if [ "${#activatescripts[@]}" -eq "2" ]; then
                echo "Found virtualenv. Activating..."
                export VIRTUAL_ENV_DISABLE_PROMPT="yes"
                source $activatescripts[1]
            fi

            current_path=`dirname $current_path`;
        done

        if [ "$nomatchopt" -eq "1" ]; then
            setopt nomatch
        fi
    fi
}

current_virtual_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo " [$(basename $VIRTUAL_ENV)]"
    fi
}

add-zsh-hook chpwd autodetect_virtualenv
