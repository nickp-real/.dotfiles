---@param key string[] | string?
local function main_mod(key)
	if type(key) == "table" then
		return table.concat({ MAIN_MOD, table.unpack(key) }, " + ")
	end
	return table.concat({ MAIN_MOD, key }, " + ")
end

---@param cmd string
local function app2unit(cmd)
	return hl.dsp.exec_cmd("app2unit -- " .. cmd)
end

hl.bind(main_mod("RETURN"), app2unit(TERMINAL))
hl.bind(main_mod("Q"), hl.dsp.window.kill())
hl.bind(main_mod("DELETE"), hl.dsp.exec_cmd("uwsm stop"))
-- bind = $mainMod, DELETE, exec, loginctl terminate-user ""
hl.bind(main_mod("E"), app2unit(FILE_EXPLORER))
-- bind = $mainMod, R, exec, wofi --show drun
-- dwindle
hl.bind(main_mod("P"), hl.dsp.window.pseudo())
hl.bind(main_mod("S"), hl.dsp.layout("togglesplit"))

-- Move focus with mainMod
hl.bind(main_mod("H"), hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod("L"), hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod("K"), hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod("J"), hl.dsp.focus({ direction = "d" }))

-- Window
hl.bind(main_mod("T"), hl.dsp.window.pin())
hl.bind(main_mod({ "SHIFT", "H" }), hl.dsp.window.move({ direction = "l" }))
hl.bind(main_mod({ "SHIFT", "L" }), hl.dsp.window.move({ direction = "r" }))
hl.bind(main_mod({ "SHIFT", "K" }), hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod({ "SHIFT", "J" }), hl.dsp.window.move({ direction = "d" }))
-- bind ( $mainMod, N,)
hl.bind(main_mod({ "SHIFT", "F" }), hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod({ "CTRL", "F" }), hl.dsp.window.center())
hl.bind(main_mod("F"), hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(main_mod("M"), hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Window split ratio
hl.bind(main_mod("Minus"), hl.dsp.layout("splitratio -0.1"))
hl.bind(main_mod("Equal"), hl.dsp.layout("splitratio 0.1"))
hl.bind(main_mod("Semicolon"), hl.dsp.layout("splitratio -0.1"))
hl.bind(main_mod("Apostrophe"), hl.dsp.layout("splitratio 0.1"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = tostring(i % 10)
	hl.bind(main_mod(key), hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod({ "SHIFT", key }), hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(main_mod("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod("mouse_up"), hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod("mouse:272"), hl.dsp.window.resize(), { mouse = true })

-- rofi
hl.bind(main_mod("R"), app2unit("launcher_t1"))
-- bind = $mainMod, R, exec, uwsm app -- rofi -show drun -theme ~/.config/rofi/launchers/type-1/style-5.rasi
hl.bind(main_mod({ "SHIFT", "ESCAPE" }), app2unit("powermenu_t3"))
hl.bind(main_mod("V"), app2unit("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

-- Screen brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s -n2 -q 10%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s -n2 -q 10%+"), { repeating = true })

-- Audio
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Screenshot
hl.bind("Print", app2unit("grimblast edit area"))
hl.bind("SHIFT + PRINT", app2unit("grimblast copy area"))
hl.bind(main_mod("PRINT"), app2unit("grimblast copy"))

-- Lock screen
hl.bind(main_mod({ "CTRL", "L" }), app2unit("hyprlock -q"))

-- # Plugins
-- # bind = SUPERSHIFT, R, hyprload, reload
-- # bind = SUPERSHIFT, U, hyprload, update
-- # bind = SUPERSHIFT, I, hyprload, install
