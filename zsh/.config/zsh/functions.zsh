#gives current weather in provide location

git-key() {
    eval "$(ssh-agent)"
    ssh-add  $HOME/.ssh/github
}

wr2() {
    curl -s wttr.in/$1\?M\&format="%l%20%C+%c+%t%20%28%f%29%3a+%w%3a+%h%20humidity%3a+%p%3a+%u%20uv%3a+%P\n"
}

#weather report for the next 3 days for provided location
wr() {
	curl -s wttr.in/$1\?M
}

dict() {
    curl -s dict://dict.org/d:$1
}

dictm() {
    curl -s dict://dict.org/m:$1
}

cht() {
    curl cht.sh/$1
}

rate() {
    curl -s rate.sx/$1
}

countdown() {
    start="$(( $(date '+%s') + $1))"
    while [ $start -ge $(date +%s) ]; do
        time="$(( $start - $(date +%s) ))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
    notify-send "countdown timer done"
}

countdown2() {
    start="$(( $(date +%s) + $1))"
    while [ "$start" -ge $(date +%s) ]; do
        ## Is this more than 24h away?
        days="$(($(($(( $start - $(date +%s) )) * 1 )) / 86400))"
        time="$(( $start - `date +%s` ))"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
    notify-send "countdown timer done"
}

colour-print-list()
{
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
lfcd () {
    tmp="$(mktemp)"
    lfrun -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

print_colors() {
    printf "|039| \033[39mDefault \033[m  |049| \033[49mDefault \033[m  |037| \033[37mLight gray \033[m     |047| \033[47mLight gray \033[m\n"
    printf "|030| \033[30mBlack \033[m    |040| \033[40mBlack \033[m    |090| \033[90mDark gray \033[m      |100| \033[100mDark gray \033[m\n"
    printf "|031| \033[31mRed \033[m      |041| \033[41mRed \033[m      |091| \033[91mLight red \033[m      |101| \033[101mLight red \033[m\n"
    printf "|032| \033[32mGreen \033[m    |042| \033[42mGreen \033[m    |092| \033[92mLight green \033[m    |102| \033[102mLight green \033[m\n"
    printf "|033| \033[33mYellow \033[m   |043| \033[43mYellow \033[m   |093| \033[93mLight yellow \033[m   |103| \033[103mLight yellow \033[m\n"
    printf "|034| \033[34mBlue \033[m     |044| \033[44mBlue \033[m     |094| \033[94mLight blue \033[m     |104| \033[104mLight blue \033[m\n"
    printf "|035| \033[35mMagenta \033[m  |045| \033[45mMagenta \033[m  |095| \033[95mLight magenta \033[m  |105| \033[105mLight magenta \033[m\n"
    printf "|036| \033[36mCyan \033[m     |046| \033[46mCyan \033[m     |096| \033[96mLight cyan \033[m     |106| \033[106mLight cyan \033[m\n"
}

function format_time() {
    local seconds=$1
    printf "%02d:%02d:%02d" $((seconds / 3600)) $(((seconds % 3600) / 60)) $((seconds % 60))
}

function pomodoro_timer() {
    local work_time="30 * 60"  # 25 minutes in seconds
    local break_time="10 * 60" # 5 minutes in seconds
    local cycles=3       # Number of Pomodoro cycles

    for ((cycle = 1; cycle <= cycles; cycle++)); do
        for ((time_left = work_time; time_left > 0; time_left--)); do
            echo -ne "Pomodoro $cycle: Work Time Left: $(format_time $time_left)\033[0K\r"
            sleep 1
        done

        echo "Time for a short break!" | festival --tts   # Notify using Festival
        notify-send "Pomodoro $cycle" "Time for a short break!" -t 5000  # Notify using notify-send

        for ((time_left = break_time; time_left > 0; time_left--)); do
            echo -ne "Pomodoro $cycle: Break Time Left: $(format_time $time_left)\033[0K\r"
            sleep 1
        done

        echo "Back to work!" | festival --tts # Notify using Festival
        notify-send "Pomodoro $cycle" "Back to work!" -t 5000  # Notify using notify-send
        
    done
    echo -ne "\033[0K\r"
    echo "Pomodoro completed!"
}
