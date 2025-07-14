return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = { "OXY2DEV/markview.nvim"},
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "markdown",
        "lua",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "bash",
        "c",
        "cpp",
        "rust",
        "go",
        "ruby",
        "vim",
      }, 
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
