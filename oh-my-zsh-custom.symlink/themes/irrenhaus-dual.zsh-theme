# Tip with ${PWD/#$HOME/~} is from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# For this you need to have the dotfiles color_definitions.zsh file loaded
define_colors

#####################
## Theme aliases
#####################

alias debug_on='touch /tmp/debug_prompt; source ~/.zshrc'
alias debug_off='rm -f /tmp/debug_prompt; source ~/.zshrc'
alias reinit='reset; source ~/.zshrc'

#####################
## Debugging options
#####################

debug_info() {
    if [ -e '/tmp/debug_prompt' ]; then
        printf "%s" "%(?.%{$txtgrn%}:)%{$txtrst%}.%{$txtred%}%? :(%{$txtrst%})"
    fi
}

#####################
## Git super status
#####################

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$txtred%}(%{$txtgrn%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$txtred%})%{$txtrst%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$txtgrn%}✓"

ZSH_THEME_GIT_PROMPT_STAGED="%{$txtgrn%}✹"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$txtblu%}✚"
ZSH_THEME_GIT_PROMPT_DELETED="%{$txtred%}✗"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$txtylw%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$txtcyn%}✖"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$txtylw%}↑"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$txtcyn%}↓"

ZSH_THEME_GIT_PROMPT_RESET="%{$txtrst%}"

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

#####################
## PROMPT
#####################

### User part of prompt
userinfo() {
    local user="$(echo "%{$bldgrn%}%n%{$txtrst%}")"
    local curdir="$(echo "%{$bldblu%}${PWD/#$HOME/~}%{$txtrst%}")"
    local on_host=""
    if [ -n "$SSH_CONNECTION" ]; then
        on_host="@$SHORT_HOST"
    fi
    printf "%s%s > %s" "$user" "$on_host" "$curdir"
}

autoload -U current_virtual_env

PROMPT='╭$(userinfo)$(git_super_status)$(current_virtual_env)
╰> '
RPROMPT='$(debug_info)'
