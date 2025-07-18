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
vim.api.nvim_create_autocmd("BufWritePre", {
 callback = function()
   local clients = vim.lsp.get_active_clients({ bufnr = 0 })
   local has_formatter = false
   
   for _, client in ipairs(clients) do
     if client.server_capabilities.documentFormattingProvider then
       has_formatter = true
       break
     end
   end
   
   if has_formatter then
     vim.lsp.buf.format({ async = false })
   end
 end,
})

-- Buffer tab/close
vim.keymap.set('n', '<leader>n', '<Cmd>bn!<CR>')
vim.keymap.set('n', '<leader>p', '<Cmd>bp!<CR>')
vim.keymap.set('n', '<leader>x', '<Cmd>Bdelete<CR>')

-- Refactor/rename
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

-- PYTHON
vim.g.python3_host_prog = "/usr/local/bin/python"

vim.opt.clipboard = "unnamedplus"
