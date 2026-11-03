local state = io.open(os.getenv("HOME") .. "/.cache/transparency", "r")
if not state then return end
state:close()

hl.window_rule({ name = "transparent-firefox", match = { class = "^(firefox)$", title = "negative:.*YouTube.*" }, opacity = "0.8 override" })
hl.window_rule({ name = "transparent-code", match = { title = "(.*)(Visual Studio Code)$" }, opacity = "0.8 override" })
hl.window_rule({ name = "transparent-apps", match = { class = "^(alacritty|vesktop|webcord|org.nickvision.cavalier|meteo|zfxtop|gping|obsidian|thunar|.blueman-manager-wrapped|org.twosheds.iwgtk|org.pulseaudio.pavucontrol)$" }, opacity = "0.7 override" })
hl.window_rule({ name = "transparent-soundcloud", match = { title = "^(SoundCloud)(.*)$" }, opacity = "0.8 override" })
hl.window_rule({ name = "transparent-spotify", match = { title = "^(Spotify)(.*)$" }, opacity = "0.7 override" })
hl.window_rule({ name = "transparent-wofi", match = { class = "^(wofi)$" }, opacity = "0.9 override" })