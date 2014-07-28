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

        local activatescripts="$(ls */bin/activate */bin/activate.csh 2>/dev/null)"
        activatescripts=($activatescripts)

        if [ "${#activatescripts[@]}" -eq "2" ]; then
            echo "Found virtualenv. Activating..."
            export VIRTUAL_ENV_DISABLE_PROMPT="yes"
            source $activatescripts[1]
        fi

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
