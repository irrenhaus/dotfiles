#####################
## Helpers
#####################

function highlight()
{
    sed "s/$1/`tput smso`&`tput rmso`/gi" "${2:--}"
}

function check_compression {
    curl -I -H 'Accept-Encoding: gzip,deflate' $1 | grep "Content-Encoding"
}

