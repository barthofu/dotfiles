hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1.33 })
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "1920x0", scale = 1, supports_hdr = 1 })
hl.monitor({ output = "DP-3", mode = "preferred", position = "2500x-1080", scale = 1 })
hl.monitor({ output = "DP-1", mode = "preferred", position = "2500x-1080", scale = 1 })

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(8aadf475)", "rgb(24273a)", "rgb(24273a)", "rgba(8aadf475)" }, angle = 45 },
            inactive_border = { colors = { "rgb(24273a)", "rgb(24273a)", "rgb(24273a)", "rgb(27273a)" }, angle = 45 },
        },
        layout = "dwindle",
        resize_on_border = true,
    },
    decoration = {
        rounding = 10,
        blur = { enabled = true, size = 10, passes = 3, new_optimizations = true, ignore_opacity = true, xray = true },
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,
        shadow = { enabled = false, range = 40, render_power = 2, offset = { 2, 2 }, color = 0x44000000 },
    },
    animations = { enabled = true },
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("crazyshot", { type = "bezier", points = { { 0.1, 1.5 }, { 0.76, 0.92 } } })
hl.curve("hyprnostretch", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.0 } } })
hl.curve("fluent_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("myBezier", { type = "bezier", points = { { 0.10, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })

hl.window_rule({ name = "picture-in-picture", match = { title = "^(Picture-in-Picture)$" }, float = true, pin = true, move = "((monitor_w*0.695)) ((monitor_h*0.04))" })
hl.layer_rule({ name = "wlogout", match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ name = "swaync-control", match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ name = "swaync-notifications", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })
hl.window_rule({ name = "moonlight", match = { class = "^(com.moonlight_stream.Moonlight)$" }, immediate = true })
hl.window_rule({ name = "pavucontrol", match = { class = "(.*org.pulseaudio.pavucontrol.*)" }, float = true, size = "700 600", move = "((monitor_w*1)-window_w-40) (50)" })
hl.window_rule({ name = "blueman", match = { class = "(.blueman-manager-wrapped)" }, float = true, size = "700 600", move = "((monitor_w*1)-window_w-40) (50)" })
hl.window_rule({ name = "iwgtk", match = { class = "(org.twosheds.iwgtk)" }, float = true, size = "700 600", move = "((monitor_w*1)-window_w-40) (50)" })
hl.window_rule({ name = "calculator", match = { class = "(org.gnome.Calculator)" }, float = true, size = "700 600", center = true })
hl.window_rule({ name = "smile", match = { class = "(it.mijorus.smile)" }, float = true, pin = true, move = "((monitor_w*1)-window_w-100) ((monitor_h*0.5))" })
hl.window_rule({ name = "wofi", match = { class = "^(wofi)$" }, animation = "windowOut" })
hl.window_rule({ name = "zfxtop", match = { class = "^(zfxtop)$" }, float = true, pin = true, size = "700 700", move = "(50) (50)" })
hl.window_rule({ name = "gping", match = { class = "^(gping)$" }, float = true, pin = true, size = "700 220", move = "(50) (50)" })
hl.window_rule({ name = "meteo", match = { class = "^(meteo)$" }, float = true, size = "1200 860", center = true })
hl.window_rule({ name = "discord", match = { class = "^(vesktop|webcord)$" }, workspace = "3 silent" })