# mh theme
# preview: http://cl.ly/1y2x0W0E3t2C0F29043z

# features:
# path is autoshortened to ~30 characters
# displays git status (if applicable in current folder)
# turns username green if superuser, otherwise it is white
#
# modified by Nils Hesse

# if superuser make the username red
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[gray]%}(%{$fg_no_bold[blue]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[gray]%})%{$reset_color%} "
#ZSH_THEME_GIT_PROMPT_CLEAN=""
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✱"

#####################
## Git super status
#####################

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$txtred%}(%{$txtgrn%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$txtred%})%{$txtrst%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_no_bold[green]%}✓"

ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_no_bold[green]%}✹"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_no_bold[blue]%}✚"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_no_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_no_bold[yellow]%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_no_bold[cyan]%}✖"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[yellow]%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[cyan]%}↓"

ZSH_THEME_GIT_PROMPT_RESET="%{$reset_color%}"

git_super_status() {
    git rev-parse --git-dir 2>/dev/null 1>/dev/null
    if [ $? -ne 0 ]; then
        return 1
    fi

    local BRANCH="$(git rev-parse --abbrev-ref HEAD)"
    local MODIFIED="$(git diff --name-status | sed 's/\([A-Z]*\)[\t ]*.*/\1/')"
    MODIFIED=($MODIFIED)
    local NUM_MODIFIED="0"
    local NUM_UNMERGED="0"
    local NUM_DELETED="0"
    local STAGED="$(git diff --staged --name-status | sed 's/\([A-Z]*\)[\t ]*.*/\1/')"
    STAGED=($STAGED)
    local NUM_STAGED="${#STAGED[@]}"
    local UNTRACKED="$(git ls-files --others --exclude-standard)"
    UNTRACKED=($UNTRACKED)
    local NUM_UNTRACKED="${#UNTRACKED[@]}"

    local REMOTE="$(git config branch.${BRANCH}.remote)"
    local MERGE_TARGET="$(git config branch.${BRANCH}.merge)"
    local MERGE_TARGET_BRANCH="${MERGE_TARGET:11}"

    for INFO in $MODIFIED; do
        if [ "${INFO:0:1}" = "M" ]; then
            NUM_MODIFIED="$(expr $NUM_MODIFIED + 1)"
        fi

        if [ "${INFO:0:1}" = "D" ]; then
            NUM_DELETED="$(expr $NUM_DELETED + 1)"
        fi

        if [ "${INFO:0:1}" = "U" ]; then
            NUM_UNMERGED="$(expr $NUM_UNMERGED + 1)"
        fi
    done

    NUM_STAGED="$(expr $NUM_STAGED - $NUM_UNMERGED)"

    local REV_LIST="$(git rev-list --left-right refs/remotes/${REMOTE}/${MERGE_TARGET_BRANCH}...HEAD 2>/dev/null)"
    REV_LIST=($REV_LIST)

    if [ -z "$REV_LIST" ]; then
        REV_LIST="$(git rev-list --left-right ${MERGE_TARGET}...HEAD 2>/dev/null)"
        REV_LIST=($REV_LIST)
    fi

    local AHEAD="0"
    local BEHIND="0"

    for REV in $REV_LIST; do
        if [ "${REV:0:1}" = ">" ]; then
            AHEAD="$(expr $AHEAD + 1)"
        fi

        if [ "${REV:0:1}" = "<" ]; then
            BEHIND="$(expr $BEHIND + 1)"
        fi
    done

    local CLEAN="1"
    if [ -z "$MODIFIED" ] && [ -z "$STAGED" ] && [ -z "$UNTRACKED" ] && [ "$AHEAD" -eq "0" ] && [ "$BEHIND" -eq "0" ] && [ "$NUM_UNMERGED" -eq "0" ]; then
        CLEAN="0"
    fi

    echo -n "$ZSH_THEME_GIT_PROMPT_PREFIX"
    echo -n "${BRANCH}${ZSH_THEME_GIT_PROMPT_RESET}"
    if [ "$CLEAN" -eq "0" ]; then
        echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
        echo -n "$ZSH_THEME_GIT_PROMPT_SUFFIX"
        return 0
    fi
    echo -n "|"

    if [ "$AHEAD" -gt "0" ] || [ "$BEHIND" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_AHEAD}${AHEAD}${ZSH_THEME_GIT_PROMPT_RESET}"
        echo -n "${ZSH_THEME_GIT_PROMPT_BEHIND}${BEHIND}${ZSH_THEME_GIT_PROMPT_RESET}"

        if [ "$NUM_MODIFIED" -gt "0" ] || [ "$NUM_STAGED" -gt "0" ] || [ "$NUM_UNTRACKED" -gt "0" ] || [ "$NUM_UNMERGED" -gt "0" ]; then
            echo -n "|"
        fi
    fi

    if [ "$NUM_MODIFIED" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_MODIFIED}${NUM_MODIFIED}${ZSH_THEME_GIT_PROMPT_RESET}"
    fi

    if [ "$NUM_DELETED" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_DELETED}${NUM_DELETED}${ZSH_THEME_GIT_PROMPT_RESET}"
    fi

    if [ "$NUM_UNMERGED" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_UNMERGED}${NUM_UNMERGED}${ZSH_THEME_GIT_PROMPT_RESET}"
    fi

    if [ "$NUM_STAGED" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_STAGED}${NUM_STAGED}${ZSH_THEME_GIT_PROMPT_RESET}"
    fi

    if [ "$NUM_UNTRACKED" -gt "0" ]; then
        echo -n "${ZSH_THEME_GIT_PROMPT_UNTRACKED}${NUM_UNTRACKED}${ZSH_THEME_GIT_PROMPT_RESET}"
    fi

    echo -n "$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

autoload -U current_virtual_env

# prompt
PROMPT='[%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[red]%}%30<...<%~%<<%{$reset_color%}]%(!.#.$) '
RPROMPT='$(git_super_status)$(current_virtual_env)'
