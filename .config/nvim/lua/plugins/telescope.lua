local builtin = require('telescope.builtin')
local log_viewer = require('telescope-log-viewer')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Configure Telescope to always open in normal mode
require('telescope').setup({
  defaults = {
    initial_mode = "normal",
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ["x"] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.api.nvim_buf_delete(selection.bufnr, { force = false })
          end,
        }
      }
    }
  },
  defaults = {
    initial_mode = "normal",
  },
})

-- KEYMAPS
--vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', function()
  require("telescope.builtin").find_files({ hidden = true })
end, { desc = 'Telescope find files (include hidden)' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Custom key mapping to find files matching a specific regex pattern
vim.keymap.set('n', '<leader>fp', function()
  require('telescope.builtin').live_grep({
    prompt_title = "Find Files (Path Regex)",
    glob_pattern = "",   -- Search all files
    additional_args = function()
      return {"--iglob", "**/*"}  -- Include all files
    end,
  })
end, { desc = 'Find files with path regex' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').treesitter, { desc = 'Find functions (treesitter)' })
vim.keymap.set('n', '<leader>fl', log_viewer.log_file_picker, { desc = 'Browse log files' })

return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    }
