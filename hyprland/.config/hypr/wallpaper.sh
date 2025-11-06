#!/usr/bin/env bash
while true; do
	BG="$(find ~/Pictures/backgrounds/catppuccin/ -name '*.jpg' -o -name '*.png' | shuf -n1)"
	PROGRAM="awww-daemon"
	trans_type="random"
	if pgrep "$PROGRAM" >/dev/null; then
		awww img "$BG" --transition-fps 120 --transition-type $trans_type --transition-duration 1
	else
		awww init && awww img "$BG" --transition-fps 120 --transition-type $trans_type --transition-duration 1
	fi
	sleep 300
done
