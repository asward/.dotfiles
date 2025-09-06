return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		},
		formatters_by_ft = {
			python = { "black" }, -- Example: Use Black for Python
			lua = { "stylua" }, -- Example: Use Stylua for Lua
			-- Add other filetypes and their respective formatters
		},
	},
}
