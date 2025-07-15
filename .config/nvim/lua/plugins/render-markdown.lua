-- render-markdown.nvim: A Neovim plugin for rendering markdown files
-- Repository: https://github.com/MeanderingProgrammer/render-markdown.nvim
return {
  "MeanderingProgrammer/render-markdown.nvim",

    -- Lazy loading: only load for specific filetypes
    -- - markdown: standard markdown files
    -- - codecompanion: AI assistant interface files
  ft = { "markdown", "codecompanion" },
}
