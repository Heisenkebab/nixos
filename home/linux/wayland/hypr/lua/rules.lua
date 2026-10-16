-- See https://wiki.hypr.land/configuring/core/rules/

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name    = "code-opacity",
    match   = { class = "code" },
    opacity = "0.9",
})

hl.window_rule({
    name    = "ghostty-opacity",
    match   = { class = "com.mitchellh.ghostty" },
    opacity = "0.9",
})

hl.window_rule({
    name      = "brave-on-2",
    match     = { class = "Brave-browser" },
    workspace = "2",
})

hl.window_rule({
    name      = "ghostty-on-1",
    match     = { class = "ghostty" },
    workspace = "1",
})
