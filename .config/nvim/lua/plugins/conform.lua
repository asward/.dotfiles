return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		},
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "jq" }, -- Example: Use jq for JSONC
			yaml = { "prettier" },
			markdown = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			rust = { "rustfmt" },
			lua = { "stylua" }, -- Add other filetypes and their respective formatters
		},
	},
}
