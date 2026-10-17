-- Fallback for unknown monitors (uncomment for debugging)
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({
	output = "desc:Samsung Electric Company U32J59x H1AK500000",
	mode = "3840x2160@60",
	position = "2160x0",
	scale = 1,
})

-- Lid switch
-- hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/lidopen.sh"), { locked = true })
-- hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/lidclose.sh"), { locked = true })

-- Workspace 10 lives on the laptop screen
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })
