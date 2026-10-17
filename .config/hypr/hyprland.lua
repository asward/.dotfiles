-- Split files (each must also be converted to Lua).
-- Note: dots in require() names mean subdirectories, so "hyprland.monitors"
-- would look for hyprland/monitors.lua. Use plain names instead.
--
--
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("clipse -listen") -- clipboard listener
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako") -- notifications (config: ~/.config/mako/config)
    hl.exec_cmd("~/.config/hypr/scripts/scratchpad-glow.py") -- white edge glow while a scratchpad is open

    -- Scratchpad apps (routed to their special workspaces by rules.lua)
    hl.exec_cmd("bitwarden-desktop")
    hl.exec_cmd("discord")
    hl.exec_cmd("google-chrome-stable --profile-directory=Default --app-id=hpfldicfbfomlpcikngkocigghgafkph") -- Google Messages
    hl.exec_cmd("google-chrome-stable --profile-directory=Default --app=https://mail.google.com/") -- Gmail
end)

require("./hyprland/monitors")
require("./hyprland/keybinds")
require("./hyprland/rules")

-----------------
---- ENV --------
-----------------

-- Theming
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("XCURSOR_THEME", "capitaine-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")
hl.env("QT_QPA_PLATFORMTHEME", "xdgdesktopportal")

-- Session
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")

-----------------
---- AUTOSTART --
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

-----------------
---- CONFIG -----
-----------------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border = "rgba(ffffff33)",
            inactive_border = "rgba(00000000)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },

    master = {
        orientation = "center",
        slave_count_for_center_master = 0,
        always_keep_position = true,
        mfact = 0.5,
    },

    decoration = {
        rounding = 0,
        inactive_opacity = 0.5, -- replaces the misplaced windowrule
        dim_special = 0.7, -- darken everything behind an open scratchpad, even an empty one
        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

-- hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
-- hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
--
-- hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
-- hl.animation({ leaf = "windows", enabled = true, speed = 1.4, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.8, bezier = "quick", style = "popin 87%" })
-- hl.animation({ leaf = "border", enabled = true, speed = 2.7, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 1.5, bezier = "quick" })
-- hl.animation({ leaf = "layers", enabled = true, speed = 1.9, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "quick", style = "fade" })

-- Scratchpads slide in vertically
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "default", style = "slidevert" })
