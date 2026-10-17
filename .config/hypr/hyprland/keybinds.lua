local mod = "SUPER"

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"), { locked = true })

-- Apps
hl.bind(mod .. " + grave", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("thunar")) -- was bound to both dolphin and thunar; thunar won
hl.bind(mod .. " + O", hl.dsp.exec_cmd("qutebrowser"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copy area"))

-- Window actions
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Focus / move windows
local dirs = { left = "l", right = "r", up = "u", down = "d" }
for key, d in pairs(dirs) do
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = d }))
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = d }))
end

-- Move current workspace between monitors
hl.bind(mod .. " + SHIFT + bracketleft", hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(mod .. " + SHIFT + bracketright", hl.dsp.workspace.move({ monitor = "+1" }))
hl.bind(mod .. " + SHIFT + H", hl.dsp.workspace.move({ monitor = 0 }))

-- Special workspace
hl.bind(mod .. " + M", hl.dsp.workspace.toggle_special("messages"))
hl.bind(mod .. " + G", hl.dsp.workspace.toggle_special("mail"))
hl.bind(mod .. " + P", hl.dsp.workspace.toggle_special("passwords"))
-- Escape closes the open scratchpad; non_consuming (bindn) so apps still get Escape
hl.bind("Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/close-special.sh"), { non_consuming = true })

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10
    -- also closes an open scratchpad, like Escape (even when i is the current workspace)
    hl.bind(mod .. " + " .. key, function()
        local special = hl.get_active_special_workspace()
        if special then
            hl.dispatch(hl.dsp.workspace.toggle_special((special.name:gsub("^special:", ""))))
        end
        hl.dispatch(hl.dsp.focus({ workspace = i }))
    end)
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Cycle open workspaces
hl.bind(mod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse move/resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Layout toggle (replaces `hyprctl keyword`)
-- hl.bind(mod .. " + M", function()
-- 	hl.config({ general = { layout = "master" } })
-- end)
hl.bind(mod .. " + D", function()
    hl.config({ general = { layout = "dwindle" } })
end)
