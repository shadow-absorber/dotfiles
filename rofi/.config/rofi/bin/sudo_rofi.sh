#!/bin/bash
pass=$(echo -e "" | rofi -dmenu -p "Enter sudo password: " -password -lines 0)
echo "$pass"

