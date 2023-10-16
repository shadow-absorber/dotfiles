# Set up less to display colored man pages
export LESS_TERMCAP_mb=$(printf '\e[1;31m')   # Bold
export LESS_TERMCAP_md=$(printf '\e[1;31m')   # Bold
export LESS_TERMCAP_me=$(printf '\e[0m')      # Reset all text attributes
export LESS_TERMCAP_se=$(printf '\e[0m')      # Reset standout mode
export LESS_TERMCAP_so=$(printf '\e[1;44;33m') # Standout mode (info boxes)
export LESS_TERMCAP_ue=$(printf '\e[0m')      # Reset underline

# Absolute path to the directory containing this script
__colored_man_pages_dir="${(%):-%x:h}"

function colored() {
  local -a environment
  environment+=( "LESS_TERMCAP_mb=${LESS_TERMCAP_mb}" )
  environment+=( "LESS_TERMCAP_md=${LESS_TERMCAP_md}" )
  environment+=( "LESS_TERMCAP_me=${LESS_TERMCAP_me}" )
  environment+=( "LESS_TERMCAP_se=${LESS_TERMCAP_se}" )
  environment+=( "LESS_TERMCAP_so=${LESS_TERMCAP_so}" )
  environment+=( "LESS_TERMCAP_ue=${LESS_TERMCAP_ue}" )
  environment+=( "PAGER=${commands[less]:-$PAGER}" )
  environment+=( "GROFF_NO_SGR=1" )

  if [[ "$OSTYPE" = solaris* ]]; then
    environment+=( "PATH=${__colored_man_pages_dir}:$PATH" )
  fi

  env "${environment[@]}" "$@"
}

# Alias man to display colored man pages
alias man='colored man'

# Alias dman and debman if they are used in your system
# alias dman='colored dman'
# alias debman='colored debman'
