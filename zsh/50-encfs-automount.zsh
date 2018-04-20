function auto_mount_encfs() {
    if [[ -z "$ENCDIR" ]] || [[ -z "$ENCMOUNTPOINT" ]] || [[ -z "$ENCFS6_CONFIG" ]]; then
        return 1
    fi

    if [[ "$PWD" == "$ENCMOUNTPOINT" ]]; then
        if [[ -n "$PREENC" ]]; then
            eval "$PREENC"
        fi

        mount | grep $ENCMOUNTPOINT >/dev/null 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -n "Password: "

            stty -echo
            read password
            stty echo

            echo ""         # force a carriage return to be output
            echo $password | encfs -S -i 30 "$ENCDIR" "$ENCMOUNTPOINT"
        fi
    fi
}

chpwd_functions=(${chpwd_functions[@]} "auto_mount_encfs")
