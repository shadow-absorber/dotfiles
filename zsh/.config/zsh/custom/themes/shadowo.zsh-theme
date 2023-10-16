PROMPT='%{$fg[yellow]%}%* %{$fg[green]%}%n%{$fg[red]%}@%{$fg[green]%}%m: %{$fg[cyan]%}%~
$(git_prompt_info)%(?:%{$fg[green]%}:%{$fg[red]%})$ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"
#ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_ADDED="✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="★"
ZSH_THEME_GIT_PROMPT_DELETED="✖"
ZSH_THEME_GIT_PROMPT_RENAMED="➜"