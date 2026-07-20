local mainMod  = "SUPER"
local terminal = "foot"
local browser  = "qutebrowser"
local editor   = "nvim"

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.5,
})

hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("foot --server")
    hl.exec_cmd("fcitx5 -d")
end)

hl.env(
  "XCURSOR_SIZE", "24",
  "HYPRCURSOR_SIZE", "24",
  "EDITOR", "nvim"
)

hl.permission(
  "/usr/(bin|local/bin)/grim", "screencopy", "allow",
  "/usr/(bin|local/bin)/wf-recorder", "screencopy", "allow",
  "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow",
  "/usr/(bin|local/bin)/hyprpm", "plugin", "allow"
)

hl.config({
    ecosystem = {
        enforce_permissions = true,
    },
    input = {
        kb_layout = "us",
        -- kb_variant = "intl",
        follow_mouse   = 1,
        natural_scroll = true,
        sensitivity    = 1.0,
        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
        },
    },
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
        font_family              = "Noto Sans",
        disable_hyprland_logo    = true,
        force_default_wallpaper  = 0,
        disable_splash_rendering = true,
    }
})

hl.curve(
  "myBezier",
  {
    type = "bezier",
    points = {
      {0.05, 0.9},
      {0.1, 1.05}
    }
  }
)

hl.animation(
  { leaf = "windows",
    enabled = true,
    speed = 7, 
    bezier = "myBezier"
  },
  {
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "default",
    style = "popin 80%"
  },
  {
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default"
  },
  {
    leaf = "borderangle",
    enabled = true,
    speed = 8,
    bezier = "default"
  },
  {
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "default"
  },
  {
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "default"
  }
)

-- Workspace
hl.bind(mainMod .. " + bracketleft",          hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + bracketright",         hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + bracketleft",  hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + bracketright", hl.dsp.window.move({ workspace = "r+1" }))

-- Preferences (brightness, volume)
hl.bind(mainMod .. " + f", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind(mainMod .. " + b", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%-"))
hl.bind(mainMod .. " + p", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 10%+"))

-- Screenshot (1: area, 2: full), screen record (3: area, 4: full, 5: stop)
local pictureDir = "~/storage/capture/picture"
local recordDir  = "~/storage/capture/record"
hl.bind(
  mainMod .. " + 1",
  hl.dsp.exec_cmd(
    [[mkdir -p ]] .. pictureDir .. [[ && grim -g "$(slurp)" - | tee ]] .. pictureDir .. [[/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy && notify-send "Screenshot" "Area captured and copied to clipboard"]]
  ),
  mainMod .. " + 2",
  hl.dsp.exec_cmd(
    [[mkdir -p ]] .. pictureDir .. [[ && grim - | tee ]] .. pictureDir .. [[/screenshot-$(date +%Y%m%d-%H%M%S).png | wl-copy && notify-send "Screenshot" "Full screen captured and copied to clipboard"]]
  ),
  mainMod .. " + 3",
  hl.dsp.exec_cmd(
    [[mkdir -p ]] .. recordDir .. [[ && notify-send "Recording" "Area recording started (SUPER+5 to stop)" && wf-recorder -g "$(slurp)" -f ]] .. recordDir .. [[/recording-$(date +'%Y-%m-%d-%H:%M:%S').mp4]]
  ),
  mainMod .. " + 4",
  hl.dsp.exec_cmd(
    [[mkdir -p ]] .. recordDir .. [[ && notify-send "Recording" "Full screen recording started (SUPER+5 to stop)" && wf-recorder -o "$(hyprctl monitors | awk '/^Monitor/ {m=$2} /focused: yes/ {print m; exit}')" -f ]] .. recordDir .. [[/recording-$(date +'%Y-%m-%d-%H:%M:%S').mp4]]
  ),
  mainMod .. " + 5",
  hl.dsp.exec_cmd(
    [[pkill --signal SIGINT wf-recorder && notify-send "Recording" "Stopped and saved to ]] .. recordDir .. [["]]
  )
)

-- Window lifecycle
hl.bind(
  -- CREATE: Launch apps
  mainMod .. " + CTRL + space",
  hl.dsp.exec_cmd(browser)
)
hl.bind(
  mainMod .. " + CTRL + Return",
  hl.dsp.exec_cmd(terminal)
  -- UPDATE: Switch window size
)

hl.bind(mainMod .. " + y", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + s", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + t", hl.dsp.window.float({ action = "toggle" }))

-- UPDATE: Move focus of window
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + d", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + u", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + r", hl.dsp.focus({ direction = "right" }))

-- UPDATE: Move window
hl.bind(mainMod .. " + SHIFT + b", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + n", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + p", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.window.move({ direction = "right" }))

-- DELETE: Kill window
hl.bind(mainMod .. " + q", hl.dsp.window.close())

-- Mouse bindings for moving and resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.window.resize({ x = 10,  y = 10 }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.window.resize({ x = -10, y = -10 }))

hl.window_rule(
  {
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
  },
  {
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
  }
)
