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
#            command -v bw &> /dev/null
            BW_STATUS="unauthenticated" #"$(bw status | jq -r '.status')"
            if [[ "$?" -ne 0 ]] || [[ "$BW_STATUS" == "unauthenticated" ]]; then
                echo -n "Password: "

                stty -echo
                read password
                stty echo
            else
                echo "Unlocking using bitwarden"
                password="$(bw get item 4742c0df-c02e-4186-8318-a83100c1d7fa | jq -r '.login.password')"
            fi

            echo ""         # force a carriage return to be output
            echo $password | encfs -S -i 30 "$ENCDIR" "$ENCMOUNTPOINT"
        fi
    fi
}

chpwd_functions=(${chpwd_functions[@]} "auto_mount_encfs")
