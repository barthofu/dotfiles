local actions = {}

function actions.toggle_all_float()
    local workspace = hl.get_active_workspace()
    if not workspace then return end
    local windows = hl.get_workspace_windows(workspace)
    local make_floating = false
    for _, window in ipairs(windows) do
        if not window.floating then make_floating = true break end
    end
    for _, window in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ window = window, action = make_floating and "on" or "off" }))
    end
end

return actions