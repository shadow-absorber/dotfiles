# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

setopt autocd       # Automatically cd into typed directory.


autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.



#set pager to most meaning that man pages get nice syntax highlighting
#export PAGER="most"
#setup for git history for dotfiles and command
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# User configuration

pkhex() {
	WINEPREFIX=/home/sam_tunder/games/pkhex-7 wine /home/sam_tunder/games/pkhex-7/drive_c/users/sam_tunder/pkhex/pkhex.exe
}

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH=/home/sam_tunder/.config/lf:/home/sam_tunder/.config/scripts:/home/sam_tunder/.local/bin:/home/sam_tunder/.pyenv/shims:/home/sam_tunder/.local/share/gem/ruby/3.0.0/bin:/home/sam_tunder/.npm/npm-global/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/opt/cuda/bin:/opt/cuda/nsight_compute:/opt/cuda/nsight_systems/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

PATH="/home/sam_tunder/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/sam_tunder/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/sam_tunder/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/sam_tunder/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/sam_tunder/perl5"; export PERL_MM_OPT;


source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^ ' autosuggest-accept

source /usr/share/doc/pkgfile/command-not-found.zsh

source $HOME/.config/zsh/coloured-man-pages.zsh

source $HOME/.config/zsh/vim-keybinds.zsh

source $HOME/.config/zsh/plugins/auto-notify.plugin.zsh

source $HOME/.config/zsh/functions.zsh
source $HOME/.config/zsh/aliases.zsh


export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# setup prompt colours
#PROMPT='%{$fg[yellow]%}%* %{$fg[green]%}%n%{$fg[red]%}@%{$fg[green]%}%m: %{$fg[cyan]%}%~ %(?..%{$fg[green]%}:%{$fg[red]%})$ %{$reset_color%}'

# PROMPT='%F{yellow}%* %F{green}%n%F{red}@%F{green}%m: %F{cyan}%~ %(?..%F{green}%F{red})
# $ %f'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.config/zsh/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000


## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

export PAGER="less"
export COLORTERM="truecolor"
# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End Underline
export LESS_TERMCAP_ue=$(tput sgr0)
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

