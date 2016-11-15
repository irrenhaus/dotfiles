ENCDIR="$HOME/Nextcloud/.encfs"
MOUNTPOINT="$HOME/encfs"

function auto_mount_encfs() {
    if [ "$PWD" == "$MOUNTPOINT" ]; then
        findmnt $MOUNTPOINT >/dev/null
        if [ $? -ne 0 ]; then
            kdeencfs "$ENCDIR" "$MOUNTPOINT"
        fi
    fi
}

chpwd_functions=(${chpwd_functions[@]} "auto_mount_encfs")
