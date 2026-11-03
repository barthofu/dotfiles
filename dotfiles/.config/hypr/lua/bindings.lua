local commands = {
    { "SUPER + RETURN", "alacritty" },
    { "SUPER + E", "thunar" },
    { "SUPER + B", "firefox" },
    { "SUPER + SHIFT + G", "firefox --new-window https://gmail.com" },
    { "SUPER + SHIFT + M", "firefox --new-window https://maps.google.com/maps" },
    { "SUPER + SHIFT + A", "firefox --new-window https://chatgpt.com/" },
    { "SUPER + semicolon", "smile" },
    { "SUPER + SHIFT + S", [[grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Images/screenshots/screenshot-$(date +%F_%T).png]] },
    { "SUPER + S", [[grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') - | wl-copy && wl-paste > ~/Images/screenshots/screenshot-$(date +%F_%T).png]] },
    { "SUPER + SHIFT + R", "$HOME/.local/scripts/screen_record.sh mp4" },
    { "SUPER + CTRL + R", "$HOME/.local/scripts/screen_record.sh gif" },
    { "SUPER + CTRL + Q", "$HOME/.local/scripts/wlogout.sh" },
    { "ALT + SPACE", "wofi --show drun" },
    { "SUPER + SPACE", "$HOME/.dotfiles/dotfiles/.local/bin/wmenu" },
    { "SUPER + L", "hyprlock" },
    { "XF86ScreenSaver", "hyprlock" },
    { "SUPER + W", "pkill -SIGUSR2 waybar" },
    { "SUPER + SHIFT + W", "$HOME/.local/scripts/select_wallpaper.sh" },
    { "SUPER + V", "$HOME/.local/scripts/cliphist.sh" },
    { "SUPER + SHIFT + C", "hyprpicker | wl-copy" },
    { "SUPER + N", "swaync-client -t -rs" },
    { "SUPER + G", "pavucontrol" },
    { "SUPER + ALT + ampersand", "$HOME/.local/scripts/connect_bluetooth.sh soundcore" },
    { "SUPER + ALT + eacute", "$HOME/.local/scripts/connect_bluetooth.sh bp50" },
    { "SUPER + ALT + quotedbl", "$HOME/.local/scripts/connect_bluetooth.sh wonderboom-3" },
    { "XF86MonBrightnessUp", "$HOME/.local/scripts/change_brightness.sh +5%" },
    { "XF86MonBrightnessDown", "$HOME/.local/scripts/change_brightness.sh 5%-" },
    { "XF86AudioRaiseVolume", "pamixer -i 5" },
    { "XF86AudioLowerVolume", "pamixer -d 5" },
    { "XF86AudioMute", "pamixer --toggle-mute" },
    { "XF86AudioMicMute", "pamixer --default-source -t" },
}

for _, binding in ipairs(commands) do
    hl.bind(binding[1], hl.dsp.exec_cmd(binding[2]))
end

for _, binding in ipairs({
    { "XF86AudioPlay", "playerctl play-pause" },
    { "XF86AudioStop", "playerctl stop" },
    { "XF86AudioNext", "playerctl next" },
    { "XF86AudioPrev", "playerctl previous" },
}) do
    hl.bind(binding[1], hl.dsp.exec_cmd(binding[2]), { locked = true })
end

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + T", hl.dsp.window.float())
hl.bind("SUPER + SHIFT + T", require("lua.actions").toggle_all_float)
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + K", hl.dsp.layout("swapsplit"))
hl.bind("SUPER + P", function()
    hl.dispatch(hl.dsp.window.float())
    hl.dispatch(hl.dsp.window.pin())
end)

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind("SUPER + " .. direction, hl.dsp.focus({ direction = direction }))
end
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

local desktop_keys = { "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "egrave", "minus", "underscore", "ccedilla", "agrave" }
local move_keys = { "ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave" }
for index, key in ipairs(desktop_keys) do
    hl.bind("SUPER + " .. key, function() hl.plugin.virtual_desktops.vdesk(tostring(index)) end)
end
for index, key in ipairs(move_keys) do
    hl.bind("SUPER + SHIFT + " .. key, function() hl.plugin.virtual_desktops.movetodesk(tostring(index)) end)
end
hl.bind("SUPER + Tab", function() hl.plugin.virtual_desktops.nextdesk() end)
hl.bind("SUPER + SHIFT + Tab", function() hl.plugin.virtual_desktops.prevdesk() end)
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + CTRL + down", hl.dsp.focus({ workspace = "empty" }))

hl.bind("switch:on:Lid Switch", function()
    hl.monitor({ output = "eDP-1", disabled = true })
end, { locked = true })
hl.bind("switch:off:Lid Switch", function()
    hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1.33 })
end, { locked = true })