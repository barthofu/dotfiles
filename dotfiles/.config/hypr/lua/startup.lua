for name, value in pairs({
    XDG_CURRENT_DESKTOP = "Hyprland",
    XDG_SESSION_DESKTOP = "Hyprland",
    XDG_SESSION_TYPE = "wayland",
    QT_QPA_PLATFORM = "wayland;xcb",
    QT_QPA_PLATFORMTHEME = "qt5ct",
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
    QT_AUTO_SCREEN_SCALE_FACTOR = "1",
    AQ_DRM_DEVICES = "/dev/dri/card1",
    GDK_SCALE = "1",
    GDK_BACKEND = "wayland,x11,*",
    CLUTTER_BACKEND = "wayland",
    MOZ_ENABLE_WAYLAND = "1",
    XCURSOR_SIZE = "24",
    APPIMAGELAUNCHER_DISABLE = "1",
    OZONE_PLATFORM = "wayland",
    ELECTRON_OZONE_PLATFORM_HINT = "wayland",
    __GLX_VENDOR_LIBRARY_NAME = "nvidia",
}) do
    hl.env(name, value)
end

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("sleep 3; $HOME/.config/waybar/launch.sh")
    hl.exec_cmd("sleep 3; $HOME/.local/scripts/restore_wallpaper.sh")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("swaync")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("jellyfin-mpv-shim")
    hl.exec_cmd("elephant")
    hl.exec_cmd("code", { workspace = "1 silent" })
    hl.exec_cmd("firefox", { workspace = "2 silent" })
    hl.exec_cmd("vesktop", { workspace = "3 silent" })
    hl.exec_cmd([[bash -c "sleep 15; soundcloud"]], { workspace = "4 silent" })
    hl.exec_cmd("spotify", { workspace = "4 silent" })
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 18")
    hl.exec_cmd([[bash -c "sleep 5; $HOME/.local/scripts/connect_bluetooth.sh bp50 && sleep 10 && $HOME/.local/scripts/connect_bluetooth.sh bp50"]])
end)