#####################
## Helpers
#####################

function highlight()
{
    sed "s/$1/`tput smso`&`tput rmso`/gi" "${2:--}"
}

