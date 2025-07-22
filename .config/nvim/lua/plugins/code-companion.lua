return {
  "olimorris/codecompanion.nvim",
  tag = "v17.10.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      cmd = {
        adapter = "anthropic",
      },
      chat = {
        adapter = "anthropic",
        opts = {
          completion_provider = "cmp",
        },
      },
      inline = {
        adapter = "anthropic",
      },
      agent = {
        adapter = "anthropic",
      },
    },
    display = {
      chat = { show_settings = true },
    },
  },
}

-- -- Key mappings
-- keys = {
--   { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion Actions" },
--   { "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Code Companion Chat" },
--   { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Code Companion Chat" },
-- },
