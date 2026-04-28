MAIN_MOD = "SUPER"
TERMINAL = "foot"
FILE_EXPLORER = "nemo"

-- Decoration
DECORATION = {
	rounding = 8,
	blur = {
		enabled = true,
		size = 8,
		passes = 2,
		xray = true,
	},
	shadow = {
		enabled = true,
		range = 20,
		render_power = 3,
		color = "rgba(1a1a1aee)",
	},
}

GENERAL = {
	gaps_in = 4,
	gaps_out = 8,
	border_size = 2,
	col = {
		active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
		inactive_border = "rgba(595959aa)",
	},
}

GESTURES = {
	workspace_swipe_distance = 200,
}

CURSOR = {
	no_warps = true,
	no_hardware_cursors = true,
}

INPUT = {
	kb_layout = "us, th",
	kb_variant = "colemak_dh, ThaiMnc",
	kb_options = "grp:win_space_toggle",

	follow_mouse = 2,
	float_switch_override_focus = 0,

	touchpad = {
		natural_scroll = true,
	},

	sensitivity = 0,
}
