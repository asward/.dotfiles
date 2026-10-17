return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- Servers are enabled explicitly via vim.lsp.enable() in init.lua
    automatic_enable = false,
  },
}
