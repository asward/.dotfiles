vim.opt.termguicolors = true


require("config.lazy")
vim.cmd.colorscheme('habamax')  -- or 'slate', 'desert', etc.

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2a2a2a', blend = 20 })


-- Buffer shortcuts
vim.keymap.set('n', '<C-s>', ':w <CR>')
-- Buffer tab/close
vim.keymap.set('n', '<leader>n', '<Cmd>bn!<CR>')
vim.keymap.set('n', '<leader>p', '<Cmd>bp!<CR>')
vim.keymap.set('n', '<leader>x', '<Cmd>Bdelete<CR>')

-- Refactor/rename
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

-- PYTHON
vim.g.python3_host_prog = "/usr/local/bin/python"
