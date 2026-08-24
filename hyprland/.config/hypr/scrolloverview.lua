----------------------
---- Niri Overview ---
----------------------
hl.config({
	plugin = {
		scrolloverview = {
			gesture_distance = 300, -- how far is the "max" for the gesture
			scale = 0.5, -- preferred overview scale
			workspace_gap = 100,
			layout = "vertical", -- vertical or horizontal
			wallpaper = 0, -- 0: global only, 1: per-workspace only, 2: both
			blur = false, -- blur only the main overview wallpaper

			shadow = {
				enabled = false,
				range = 50,
				render_power = 3,
				color = "rgba(ee1a1a1a)",
			},
		},
	},
})

hl.define_submap("scrolloverview", function()
	hl.bind("left", hl.plugin.scrolloverview.navigate("left"))
	hl.bind("right", hl.plugin.scrolloverview.navigate("right"))
	hl.bind("up", hl.plugin.scrolloverview.navigate("up"))
	hl.bind("down", hl.plugin.scrolloverview.navigate("down"))
	hl.bind("Return", hl.plugin.scrolloverview.overview("select"))
	hl.bind("Escape", hl.plugin.scrolloverview.overview("off"))
	hl.bind("mouse:272", function()
		-- Select the clicked window, or just the workspace if no window was clicked, then close the overview. This is the default behaviour if submap is not defined.
		hl.plugin.scrolloverview.overview("select")
		hl.plugin.scrolloverview.window("select")
		hl.plugin.scrolloverview.overview("off")
	end, { mouse = true })
end)

local mainMod = "SUPER" -- Sets "Windows" key as main modifier
hl.bind(mainMod .. " + O", function()
	hl.plugin.scrolloverview.overview("toggle")
end)
