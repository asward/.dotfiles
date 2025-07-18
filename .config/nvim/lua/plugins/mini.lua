return {
  'echasnovski/mini.nvim',
  version = '*',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('mini.icons').setup()
    require('mini.files').setup()
    require('mini.indentscope').setup(
      {
        -- Draw options
        draw = {
          -- Delay (in ms) between event and start of drawing scope indicator
          delay = 0,
          -- Animation rule for scope's first drawing. Can be animating function or table with such function and other data.
          animation = function() return 0 end, -- Remove animation
          -- Symbol priority. Increase to display on top of more symbols.
          priority = 2,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = 'ii',
          object_scope_with_border = 'ai',
          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '[i',
          goto_bottom = ']i',
        },

        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to treat as border.
          border = 'both',
          -- Whether to use cursor column when computing reference indent.
          indent_at_cursor = true,
          -- Whether to first check input line to be a border of adjacent scope.
          try_as_border = false,
        },

        -- Which character to use for drawing scope indicator
        symbol = '│',
      }
    )
    --require('mini.map').setup()
    require('mini.animate').setup()
    --require('mini.tabline').setup()
    --require('mini.statusline').setup()
    require('mini.diff').setup()

    --vim.keymap.set('n', '<Leader>mc', MiniMap.close)
    --vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
    --vim.keymap.set('n', '<Leader>mo', MiniMap.open)
    --vim.keymap.set('n', '<Leader>mr', MiniMap.refresh)
    --vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side)
    --vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)
  end,
}
