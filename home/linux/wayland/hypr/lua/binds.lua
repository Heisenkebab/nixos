local monitors = require("user.monitors")

local mainMod  = "SUPER"
local terminal = "ghostty"
-- noctalia is the shell under both compositors (same commands as niri.nix)
local noctalia = function(args) return hl.dsp.exec_cmd("noctalia msg " .. args) end

local function bind(keys, action, opts)
    hl.bind(mainMod .. (keys ~= "" and " + " .. keys or ""), action, opts)
end

--------------------
---- APPS / WM ----
--------------------

bind("R",         hl.dsp.reload_config())
bind("SPACE",     noctalia("panel-toggle launcher"))
bind("D",         noctalia("panel-toggle launcher"))
bind("SHIFT + N", noctalia("panel-toggle control-center notifications"))
bind("ALT + L",   noctalia("session lock"))
bind("SHIFT + C", hl.dsp.exit())
bind("Q",         hl.dsp.exec_cmd(terminal))
bind("C",         hl.dsp.window.close())

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

bind("SHIFT + I", hl.dsp.layout("togglesplit"))
bind("M",         hl.dsp.window.fullscreen({ mode = "maximized" }))
bind("SHIFT + M", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Focus and move: vim keys and arrows
local directions = {
    { "H", "left",  "left" },
    { "L", "right", "right" },
    { "K", "up",    "up" },
    { "J", "down",  "down" },
}
for _, d in ipairs(directions) do
    local vim, arrow, dir = d[1], d[2], d[3]
    bind(vim,               hl.dsp.focus({ direction = dir }))
    bind(arrow,             hl.dsp.focus({ direction = dir }))
    bind("SHIFT + " .. vim, hl.dsp.window.move({ direction = dir }))
    bind("SHIFT + " .. arrow, hl.dsp.window.move({ direction = dir }))
end

--------------------
---- WORKSPACES ----
--------------------

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind(tostring(key),             hl.dsp.focus({ workspace = i }))
    bind("SHIFT + " .. key,         hl.dsp.window.move({ workspace = i }))
end

bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind("mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad
bind("Return",         hl.dsp.workspace.toggle_special())
bind("SHIFT + Return", hl.dsp.window.move({ workspace = "special" }))

-------------------------
---- MOUSE / DRAGGING ----
-------------------------

bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------
---- MONITORS ----
------------------

bind("P",         function() monitors.mirror() end)
bind("SHIFT + P", function() monitors.extend() end)

---------------
---- MEDIA ----
---------------

-- same keys as niri.nix; `locked` keeps them working on the lockscreen
local media = {
    XF86AudioRaiseVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+",
    XF86AudioLowerVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-",
    XF86AudioPlay        = "playerctl play-pause",
    XF86AudioPause       = "playerctl play-pause",
    XF86AudioNext        = "playerctl next",
    XF86AudioPrev        = "playerctl previous",
    XF86AudioStop        = "playerctl stop",
}
for key, cmd in pairs(media) do
    hl.bind(key, hl.dsp.exec_cmd(cmd), { locked = true, repeating = key:find("Volume") ~= nil })
end
