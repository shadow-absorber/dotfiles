#!/usr/bin/env bash
while true; do
	BG="$(find ~/Pictures/backgrounds/catppuccin/ -name '*.jpg' -o -name '*.png' | shuf -n1)"
	PROGRAM="swww-daemon"
	trans_type="random"
	if pgrep "$PROGRAM" >/dev/null; then
		swww img "$BG" --transition-fps 120 --transition-type $trans_type --transition-duration 1
	else
		swww init && swww img "$BG" --transition-fps 120 --transition-type $trans_type --transition-duration 1
	fi
	sleep 300
done
