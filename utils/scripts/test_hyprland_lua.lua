local dotfiles = assert(os.getenv("DOTFILES_DIR"))
local config = assert(os.getenv("HYPRLAND_TEST_CONFIG"))
package.path = dotfiles .. "/dotfiles/.config/hypr/?.lua;" .. package.path

local original_on = hl.on
hl.on = function(event, callback)
    if event ~= "hyprland.start" and event ~= "hyprland.shutdown" then return original_on(event, callback) end
end
dofile(config)
hl.on = original_on