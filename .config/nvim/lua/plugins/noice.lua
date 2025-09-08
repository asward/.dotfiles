return {
	"folke/noice.nvim",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	-- event = "VeryLazy",
	lazy = false,
	priority = 1000,
	config = function()
		require("noice").setup({
			views = {
				notify = {
					replace = true,
				},
			},
			-- Add keymaps
			keys = {
				["<Esc>"] = {
					function()
						require("noice").cmd("dismiss")
					end,
					desc = "Dismiss all notifications",
				},
			},
		})
	end,
}
