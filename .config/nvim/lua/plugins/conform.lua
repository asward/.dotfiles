return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		},
		formatters_by_ft = {
			-- Web development
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },

			-- System languages
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			go = { "goimports", "gofmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },

			-- Shell/config
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },

			-- Fallback
			["_"] = { "trim_whitespace" },
		},
	},
}
