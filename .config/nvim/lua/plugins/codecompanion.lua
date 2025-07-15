return {
  "olimorris/codecompanion.nvim",
  opts = {
		completion_provder = coc,
		    log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
	},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
