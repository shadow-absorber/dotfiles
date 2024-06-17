export ZDOTDIR="$HOME/.config/zsh"

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="nsxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less -r"
export SUDO_ASKPASS="$HOME/.config/rofi/bin/sudo_rofi.sh"

# move apps to xdg dirs
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export PERL_CPANM_HOME="$XDG_CACHE_HOME"/cpanm
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GOPATH="$XDG_DATA_HOME"/go
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export WINEPREFIX="$XDG_DATA_HOME"/wine
export W3M_DIR="$XDG_CONFIG_HOME"/w3m
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

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
