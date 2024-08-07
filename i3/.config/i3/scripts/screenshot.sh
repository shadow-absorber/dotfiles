#!/bin/sh

# Inspired heavily from bwmenu https://github.com/mattydebie/bitwarden-rofi
# Prerequisites:
#  * maim: https://github.com/naelstrof/maim
#  * xclip: https://github.com/astrand/xclip (for x11)
#  * wl-clipboard: https://github.com/bugaevc/wl-clipboard (for wayland)
#  * rofi: https://github.com/DaveDavenport/rofi
# Optional:
#  * libnotify (for notify-send)
#  * dunst (or similar for displaying notifications)
#  One of:
#    * nsxiv: https://github.com/nsxiv/nsxiv
#    * sxiv: https://github.com/muennich/sxiv
#    * feh: https://feh.finalrewind.org/

progname=${0##*/}
version=1.4

usage() {
  echo "usage: $progname [-V] [-c] [-f|-s]"
}

if ! which rofi > /dev/null 2>&1; then
  echo "Error: Rofi is required for $progname" > /dev/stderr
  if [ -w $HOME/.xsession-errors ]; then
    date "+%F %T: Error: Rofi is required for $progname" >> $HOME/.xsession-errors
  fi
  exit 1
fi

view_image() {
  # Add code to pick image viewer
  if which nsxiv > /dev/null 2>&1; then
    nsxiv "$1"
  elif which sxiv > /dev/null 2>&1; then
    sxiv "$1"
  elif which feh > /dev/null 2>&1; then
    feh "$1"
  else
    rofi -e "Error: No compatible image viewer found (Options: nsxiv, sxiv, feh)"
    exit 1
  fi
}

send_notification() {
  # Add code to pick notification sender
  if which notify-send > /dev/null 2>&1; then
    notify-send "$1"
  else
    echo "Warning: For notifications, install libnotify (notify-send)" > /dev/stderr
  fi
}

toggle_cursor() {
  if [[ $cursor_state = hidden ]]; then
    unset cursor
    cursor_state=shown
  else
    cursor=-u
    cursor_state=hidden
  fi
}

toggle_delay() {
  case $delay_secs in
     0) delay_secs=3;;
     3) delay_secs=5;;
     5) delay_secs=10;;
    10) delay_secs=30;;
    30) delay_secs=60;;
     *) delay_secs=0;;
  esac
}

toggle_save() {
  case $save_mode in
    clipboard) save_mode=file;;
    file) save_mode=view;;
    *) save_mode=clipboard;;
  esac
}

cursor=-u
cursor_state=hidden
delay_secs=0
save_mode=clipboard
v_count=0
while getopts ":hVcd:fs" opt; do
  case $opt in
    c)
      toggle_cursor
      ;;
    d)
      if [[ $OPTARG = +([0-9]) ]]; then
        delay_secs=$OPTARG
      else
        echo "Error: -d requires an integer ('$OPTARG' is invalid)" && exit 1
      fi
      ;;
    f)
      toggle_save
      ;;
    s)
      toggle_save
      toggle_save
      ;;
    V)
      v_count=$((v_count+1))
      ;;
    h|\?)
      usage
      ;;
  esac
done
shift $((OPTIND -1))

case $v_count in
  1)
    echo $progname $version
    exit 0
    ;;
  2)
    echo $version
    exit 0
    ;;
esac

maim_installed=0
flameshot_installed=0
scrot_installed=0
#
#if which scrot > /dev/null 2>&1; then
#  scrot_installed=1
#  default_app=scrot
#else
#  checked="$checked, scrot"
#fi
#if which flameshot > /dev/null 2>&1; then
#  flameshot_installed=1
#  default_app=flameshot
#else
#  checked="$checked, flameshot"
#fi
if which maim > /dev/null 2>&1; then
  maim_installed=1
  default_app=maim
else
  checked="$checked, maim"
fi

if [[ $((maim_installed+scrot_installed+flameshot_installed)) = 0 ]]; then
  rofi -e "Error: Cannot find screenshot command (looked for ${checked#, })" > /dev/stderr
  exit 1
fi

rofi_menu() {
  choice=$( { \
    if [[ $maim_installed = 1 ]]; then
      echo "Selected area"
      echo "Active window"
      echo "Entire desktop"
      xrandr | awk '$2=="connected"{if($3=="primary")r=$4;else r=$3;print "Monitor " $1 " (" r ")"}'
    fi
      } | rofi -dmenu -p 'Take Screenshot' -i -no-custom \
        -mesg "<b>Alt+c</b>: Toggle Cursor ($cursor_state) | <b>Alt+s</b>: Toggle Save ($save_mode)
<b>Alt+d</b>: Toggle Delay ($delay_secs seconds) | <b>Alt+0</b>: Remove Delay | <b>Alt+3</b>: Set Delay to 3 seconds" \
        -select "$choice" \
        -kb-custom-11 Alt+c -kb-custom-12 Alt+s -kb-custom-13 Alt+d \
        -config ~/.config/rofi/rofidmenu.rasi )
  case $? in
    0) ;;
    12) delay_secs=3 ; rofi_menu "$choice";;
    19) delay_secs=0 ; rofi_menu "$choice";;
    20) toggle_cursor ; rofi_menu "$choice";;
    21) toggle_save ; rofi_menu "$choice";;
    22) toggle_delay ; rofi_menu "$choice";;
    *) exit $?;;
  esac
}

take_screenshot() {
  unset output_file
  [[ -n "$3" ]] && output_file=$3
  case $1 in
    maim)
      case $2 in
        Selected\ area) maim --quiet --delay $delay_secs $cursor --select $output_file;;
        Entire\ desktop) maim --quiet --delay $delay_secs $cursor $output_file;;
        Active\ window) maim --quiet --delay $delay_secs $cursor -i "$(xdotool getactivewindow)" $output_file;;
        Monitor\ *)
          maim -g $(echo $2|awk -F'[()]' '{print $2}') $output_file;;
      esac
      ;;
  esac
}

rofi_menu
case $save_mode in
  clipboard)
    if which xclip > /dev/null 2>&1; then
      take_screenshot maim "$choice" | xclip -selection clipboard -t image/png
      send_notification "$choice copied to clipboard"
    elif which wl-copy > /dev/null 2>&1; then
      take_screenshot maim "$choice" | wl-copy -t image/png
      send_notification "$choice copied to clipboard"
    else
      rofi -e "Error: Cannot find xclip"
      exit 1
    fi
    ;;
  file)
    filename=$(date "+$HOME/Pictures/Screenshots/screenshot-%F-%H-%M-%S.png")
    take_screenshot maim "$choice" "$filename"
    send_notification "$choice saved to $filename"
    ;;
  view)
    dirname=$(mktemp -d)
    take_screenshot maim "$choice" "$dirname/screenshot.png"
    view_image "$dirname/screenshot.png"
    rm -Rf "$dirname"
    ;;
  *)
    rofi -e "Invalid choice"
    ;;
esac
