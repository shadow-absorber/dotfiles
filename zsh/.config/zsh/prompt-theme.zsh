# Function to get current status of git repo
parse_git_dirty() {
    local status dirty untracked ahead newfile renamed deleted bits

    status=$(git status 2>&1 | tee)
    dirty=$(echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null; echo "$?")
    untracked=$(echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null; echo "$?")
    ahead=$(echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null; echo "$?")
    newfile=$(echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null; echo "$?")
    renamed=$(echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null; echo "$?")
    deleted=$(echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null; echo "$?")
    bits=''

    if [[ "${renamed}" -eq "0" ]]; then
        bits=">${bits}"
    fi

    if [[ "${ahead}" -eq "0" ]]; then
        bits="*${bits}"
    fi

    if [[ "${newfile}" -eq "0" ]]; then
        bits="+${bits}"
    fi

    if [[ "${untracked}" -eq "0" ]]; then
        bits="?${bits}"
    fi

    if [[ "${deleted}" -eq "0" ]]; then
        bits="x${bits}"
    fi

    if [[ "${dirty}" -eq "0" ]]; then
        bits="!${bits}"
    fi

    if [[ -n "${bits}" ]]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

# Customize Zsh prompt
PROMPT='%F{yellow}%* %F{green}%n%f@%F{green}%m%f:%F{cyan}%~%f%n$(parse_git_dirty)%F{red}%(?..%?)%f %# '

# Optionally, you can set the Git prompt symbols as variables
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"
ZSH_THEME_GIT_PROMPT_ADDED="✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="★"
ZSH_THEME_GIT_PROMPT_DELETED="✖"
ZSH_THEME_GIT_PROMPT_RENAMED="➜"
