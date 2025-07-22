return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 49,
  opts = {
    preview = {
      filetypes = { "codecompanion" },
      ignore_buftypes = { "markdown" },
    },
  },

  -- For blink.cmp's completion
  -- source
  dependencies = {
    "saghen/blink.cmp"
  },
};
