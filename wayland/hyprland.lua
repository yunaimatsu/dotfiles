-- ~/.config/hypr/hyprland.lua
-- Translated from the legacy hyprlang config into the Hyprland v0.55+ Lua API.
-- Reference: https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------
hl.monitor({ output = "eDP-1",    mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1.5 })

---------------
---- INPUT ----
---------------
hl.config({
  input = {
    kb_layout      = "us",
    -- kb_variant  = "intl",
    follow_mouse   = 1,
    natural_scroll = true,
    sensitivity    = 1.0,
    touchpad = {
      natural_scroll       = true,
      disable_while_typing = true,
    },
  },
})

-----------------------
---- GENERAL / LOOK ---
-----------------------
hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 5,
    border_size = 1,
    col = {
      active_border   = "rgba(888888ff)",
      inactive_border = "rgba(111111ff)",
    },
    layout        = "dwindle",
    allow_tearing = false,
  },
  dwindle = {
    pseudotile          = true,
    preserve_split      = true,
    default_split_ratio = 1.0,
    force_split         = 2,
  },
  decoration = {
    rounding         = 5,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    blur = {
      enabled = true,
      size    = 10,
      passes  = 1,
    },
  },
  animations = {
    enabled = true,
  },
  misc = {
    disable_hyprland_logo    = true,
    force_default_wallpaper  = 0,
    disable_splash_rendering = true,
  },
})

--------------------
---- ANIMATIONS ----
--------------------
-- Old: bezier = myBezier, 0.05, 0.9, 0.1, 1.05
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("mako")
  hl.exec_cmd("foot --server")
  hl.exec_cmd("fcitx5 -d")
end)

-------------------
---- VARIABLES ----
-------------------
local mod      = "ALT"
local terminal = "foot"
local browser  = "google-chrome-stable"

--------------------
---- KEYBINDINGS ---
--------------------

-- Workspace
hl.bind(mod .. " + ALT + bracketleft",    hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + ALT + bracketright",   hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + SHIFT + bracketleft",  hl.dsp.window.move({ workspace = "m-1" }))
hl.bind(mod .. " + SHIFT + bracketright", hl.dsp.window.move({ workspace = "m+1" }))

-- Preferences: brightness / volume
hl.bind(mod .. " + ALT + f", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind(mod .. " + ALT + b", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(mod .. " + ALT + n", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%-"))
hl.bind(mod .. " + ALT + p", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"))

-- Screenshot / screen record
-- Long-bracket [[ ]] strings avoid escaping the inner quotes and $() substitutions.
hl.bind(mod .. " + ALT + 1", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | tee ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy && notify-send "Screenshot" "Area captured and copied to clipboard"]]))
hl.bind(mod .. " + ALT + 2", hl.dsp.exec_cmd([[grim - | tee ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy && notify-send "Screenshot" "Full screen captured and copied to clipboard"]]))
hl.bind(mod .. " + ALT + 3", hl.dsp.exec_cmd([[wf-recorder -g "$(slurp)" -f ~/.archive/recording-$(date +'%Y-%m-%d-%H:%M:%S').mp4]]))
hl.bind(mod .. " + ALT + 4", hl.dsp.exec_cmd([[wf-recorder -f ~/.archive/recording-$(date +'%Y-%m-%d-%H:%M:%S').mp4]]))

-- CREATE: launch apps
hl.bind(mod .. " + ALT + space",  hl.dsp.exec_cmd(browser))
hl.bind(mod .. " + ALT + Return", hl.dsp.exec_cmd(terminal))

-- UPDATE: window size / state
hl.bind(mod .. " + ALT + y", hl.dsp.window.fullscreen())
hl.bind(mod .. " + ALT + s", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + ALT + t", hl.dsp.window.float({ action = "toggle" }))

-- UPDATE: move focus
hl.bind(mod .. " + ALT + l", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + ALT + d", hl.dsp.focus({ direction = "d" }))
hl.bind(mod .. " + ALT + u", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + ALT + r", hl.dsp.focus({ direction = "r" }))

-- UPDATE: move window
hl.bind(mod .. " + SHIFT + b", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + n", hl.dsp.window.move({ direction = "d" }))
hl.bind(mod .. " + SHIFT + p", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + f", hl.dsp.window.move({ direction = "r" }))

-- DELETE: kill window
hl.bind(mod .. " + ALT + q", hl.dsp.window.close())

-- Mouse: move / resize by dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize active window with mod + scroll
-- NOTE: verify the resize argument against your installed version (see message).
hl.bind(mod .. " + mouse_down", hl.dsp.window.resize({ size = "10 10" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.window.resize({ size = "-10 -10" }))