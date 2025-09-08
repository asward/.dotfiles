return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")
		notify.setup({
			stages = "fade_in_slide_out",
			timeout = 3000,
			background_colour = "#000000",
			render = "compact",
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			vim.keymap.set("n", "<Esc>", function()
				require("notify").dismiss({ silent = true, pending = true })
			end, { desc = "Clear notifications" }),
		})
		vim.notify = notify
	end,
}
