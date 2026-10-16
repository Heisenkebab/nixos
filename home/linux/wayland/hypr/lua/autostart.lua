-- hyprland-session.target is started by home-manager (systemd.enable).
-- Same session as niri.nix's spawn-at-startup: noctalia is the shell (bar,
-- wallpaper, notifications, idle/lock), so hyprpaper/hypridle aren't started.

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")

    -- second argument: window rule effects for the spawned window
    hl.exec_cmd("ghostty", { workspace = "1 silent" })
    hl.exec_cmd("brave",   { workspace = "2 silent" })
    hl.exec_cmd("spotify")
    hl.exec_cmd("vesktop")
end)
