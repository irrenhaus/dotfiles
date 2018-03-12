ENCDIR="$HOME/Nextcloud/.encfs"
MOUNTPOINT="$HOME/encfs"

export ENCFS6_CONFIG=$HOME/.encfs6.xml

function auto_mount_encfs() {
    if [ "$PWD" == "$MOUNTPOINT" ]; then
        mount | grep $MOUNTPOINT >/dev/null 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -n "Password: "

            stty -echo
            read password
            stty echo

            echo ""         # force a carriage return to be output
            echo $password | encfs -S -i 30 "$ENCDIR" "$MOUNTPOINT"
        fi
    fi
}

chpwd_functions=(${chpwd_functions[@]} "auto_mount_encfs")
