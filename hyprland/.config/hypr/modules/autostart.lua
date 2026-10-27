-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload")
	hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark-cursors 32")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("awww init")
	hl.exec_cmd("awww-daemon --format argb")
	hl.exec_cmd("/home/user/.config/hypr/wallpaper.sh")

	hl.exec_cmd("wl-paste --watch cliphist store")

	hl.exec_cmd("mpd-mpris -port 6600")

	hl.exec_cmd("nm-applet")
	hl.exec_cmd("swaync")
	hl.exec_cmd("waybar --config $HOME/.config/waybar/hyprland-waybar.jsonc")
	hl.exec_cmd("pika-backup-monitor")
end)
