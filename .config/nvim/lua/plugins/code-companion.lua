local api_key = vim.env.ANTHROPIC_API_KEY or ""


return {
  "olimorris/codecompanion.nvim",
  tag = "v17.8.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
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
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = vim.env.ANTHROPIC_API_KEY or "",
            },
            schema = {
              model = {
                default = "claude-3-5-sonnet-latest",
              },
            },
          })
        end,
      },
    })
  end,
  
  -- -- Key mappings
  -- keys = {
  --   { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Code Companion Actions" },
  --   { "<Leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Code Companion Chat" },
  --   { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to Code Companion Chat" },
  -- },
}
