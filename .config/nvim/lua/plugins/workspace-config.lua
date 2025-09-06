return {
	"asward/workspace-config.nvim",
	event = "VeryLazy",
	config = function()
		require("workspace-config").setup()
	end,
}
