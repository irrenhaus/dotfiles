virtualpath_chpwd() {
    if [ -n "$OLD_VIRTUAL_PATH" ]; then
        echo "Resetting PATH variable"
        export PATH="${OLD_VIRTUAL_PATH}"
        export OLD_VIRTUAL_PATH=""
    else
        if [ -f './.virtualpath.conf' ]; then
            export OLD_VIRTUAL_PATH="${PATH}"
            for VPATH in `cat ./.virtualpath.conf`; do
                if [ "${VPATH:0:1}" != "/" ]; then
                    VPATH="$(pwd)/${VPATH}"
                fi
                echo "Adding virtualpath ${VPATH} to the PATH variable."
                export PATH="${VPATH}:${PATH}"
            done
        fi
    fi
}

add-zsh-hook chpwd virtualpath_chpwd
