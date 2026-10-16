-- Entry point, required from the hyprland.lua home-manager generates.
-- Each module lives in ~/.config/hypr/user/<name>.lua (sources: home/linux/wayland/hypr/lua/).
-- Host-specific overrides still come from desktop.wm.hyprland.additionalSettings
-- in flake.nix and are applied after these files.

require("user.monitors")
require("user.settings")
require("user.binds")
require("user.rules")
require("user.autostart")
