hl.window_rule({ match = { title = ".*Emulator.*" }, float = true })
hl.window_rule({ match = { class = "rofi" }, float = true })
hl.window_rule({ match = { class = ".*polkit-kde-authentication.*" }, float = true })
hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { title = "Open File" }, float = true })

hl.window_rule({ match = { class = "Slack" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "spotify" }, workspace = "5 silent" })

-- # xwaylandvideobridge
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = { class = "xwaylandvideobridge" },

	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = 0.0,
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
