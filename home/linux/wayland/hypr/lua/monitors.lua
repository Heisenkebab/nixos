-- Monitor layout comes from the host's `monitors` list in flake.nix
-- (desktop.monitors), rendered by Nix into nix/monitors.lua.

local monitors = require("nix.monitors")

local M = {}

local function rule(m)
    return {
        output   = m.name,
        mode     = string.format("%dx%d@%s", m.width, m.height, m.refresh),
        position = string.format("%dx%d", m.x, m.y),
        scale    = m.scale and tostring(m.scale) or "auto",
        transform = m.rotation // 90,
        -- 2 = only for fullscreen apps, closest to niri's "on-demand"
        vrr      = m.vrr and 2 or 0,
    }
end

function M.primary()
    for _, m in ipairs(monitors) do
        if m.primary then return m end
    end
    return monitors[1]
end

-- Extended layout, as declared in flake.nix.
function M.extend()
    for _, m in ipairs(monitors) do
        hl.monitor(rule(m))
    end
end

-- Every other monitor mirrors the primary one.
function M.mirror()
    local primary = M.primary()
    for _, m in ipairs(monitors) do
        local r = rule(m)
        if m.name ~= primary.name then
            r.mirror = primary.name
        end
        hl.monitor(r)
    end
end

M.extend()

return M
