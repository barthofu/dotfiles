hl.config({
    input = {
        kb_layout = "fr",
        kb_variant = "azerty",
        kb_model = "",
        kb_options = "",
        numlock_by_default = true,
        follow_mouse = 1,
        mouse_refocus = false,
        touchpad = {
            natural_scroll = false,
            scroll_factor = 0.5,
        },
        accel_profile = "custom 0.5 0.0 0.5",
        sensitivity = 0.0,
    },
    dwindle = {
        preserve_split = true,
    },
    binds = {
        workspace_back_and_forth = true,
        allow_workspace_cycles = true,
        pass_mouse_when_bound = false,
    },
    cursor = {
        no_hardware_cursors = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        initial_workspace_tracking = 1,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.device({
    name = "syna2ba6:00-06cb:cf00-touchpad",
    sensitivity = 0.2,
    accel_profile = "adaptive",
})