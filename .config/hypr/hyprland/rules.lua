-- Dialogs: float, center, and stay fully opaque even when unfocused
-- (overrides decoration.inactive_opacity = 0.5)

-- Windows that properly flag themselves as modal
hl.window_rule({
    name = "modal-dialogs",
    match = { modal = true },
    float = true,
    center = true,
    opacity = "1.0 override 1.0 override",
})

-- Apps that don't set the modal flag: catch common dialog titles.
-- Add more with what `hyprctl clients` shows while the dialog is open.
hl.window_rule({
    name = "dialog-titles",
    match = {
        title =
        "(?i)^(open|save|save as|open file|select.*|choose.*|preferences|settings|properties|confirm.*|are you sure.*|.*dialog.*)$",
    },
    float = true,
    center = true,
    opacity = "1.0 override 1.0 override",
})
-- Scratchpad apps, matched by class (titles change; classes don't).
-- "silent" opens them into the pad without popping it open.
-- Discord
hl.window_rule({
    match = { class = "^discord$" },
    workspace = "special:messages silent",
})

-- Google Messages PWA (installed Chrome app)
hl.window_rule({
    match = { class = "^chrome-hpfldicfbfomlpcikngkocigghgafkph-Default$" },
    workspace = "special:messages silent",
})

-- Gmail app window (launched with `google-chrome --app=https://mail.google.com/`,
-- see ~/.local/share/applications/gmail.desktop); normal Chrome tabs are left alone
hl.window_rule({
    match = { class = "^chrome-mail\\.google\\.com__.*$" },
    workspace = "special:mail silent",
})

-- Bitwarden
hl.window_rule({
    match = { class = "^Bitwarden$" },
    workspace = "special:passwords silent",
})

-- Scratchpads: never fade/dim their windows (overrides decoration.inactive_opacity = 0.5)
for _, ws in ipairs({ "special:messages", "special:mail", "special:passwords" }) do
    hl.window_rule({
        name = "scratchpad-no-dim-" .. ws,
        match = { workspace = ws },
        no_dim = true,
        opacity = "1.0 override 1.0 override",
    })

    -- Wide outer gaps so the background shows around the edges
    hl.workspace_rule({ workspace = ws, gaps_out = 60, border_size = 2 })
end

-- Template for a specific stubborn app (fill in from `hyprctl clients`):
-- hl.window_rule({
--     match   = { class = "^(app-class)$", title = "^(Dialog Title)$" },
--     float   = true,
--     center  = true,
--     opacity = "1.0 override 1.0 override",
-- })
