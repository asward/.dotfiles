return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local telescope = require('telescope')
    telescope.load_extension('file_browser')

    local fb = telescope.extensions.file_browser

    -- vim.keymap.set('n', '<leader>fb', function()
    --   fb.file_browser()
    -- end, { desc = 'File Browser (cwd)' })

    vim.keymap.set('n', '<leader>fB', function()
      fb.file_browser({
        path = vim.fn.expand('%:p:h'),
        select_buffer = true,
      })
    end, { desc = 'File Browser (current file dir)' })
  end,
}

