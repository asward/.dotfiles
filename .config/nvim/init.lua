vim.opt.termguicolors = true
vim.cmd.colorscheme('habamax')

require("config.lazy")

-- Hybrid line numbers
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = 'white', bg = 'NONE' })
vim.opt.number = true
vim.opt.updatetime = 250
vim.opt.relativenumber = true

-- No sign column - diagnostics will color the line numbers directly
vim.opt.signcolumn = 'no'
vim.opt.list = true
vim.opt.listchars = {
  eol = "↴",
  --  tab = "│⋅",
  --  trail = "•",
  --  extends = "❯",
  --  precedes = "❮",
}

-- Base line number colors
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#6272a4' })                    -- Relative numbers
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ff79c6', bold = true }) -- Current line


-- vim.api.nvim_set_hl(0, "@ilb.scope.char.1", { fg = "#d3869b" })
-- vim.api.nvim_set_hl(0, "@ilb.scope.underline.1", { fg = "#d3869b", underline = true })

vim.api.nvim_set_hl(0, 'IblScope', { fg = '#ff6c6b', bold = true })


-- Diagnostic line number colors (no background)
vim.api.nvim_set_hl(0, 'DiagnosticLineNrError', { fg = '#ff6c6b', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrWarn', { fg = '#ECBE7B', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrInfo', { fg = '#51afef', bold = true })
vim.api.nvim_set_hl(0, 'DiagnosticLineNrHint', { fg = '#98be65', bold = true })

-- Configure diagnostics to use line numbers for signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticLineNrError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticLineNrWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticLineNrInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticLineNrHint',
    },
  },
  float = {
    show_header = true,
    source = 'always',
    border = 'rounded',
    focusable = false,
  },
  virtual_text = true,
  underline = true,
})

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#ff6c6b' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = '#ECBE7B' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = '#51afef' })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = '#98be65' })
-- -- Line Numbers
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"
--
-- -- CursorLine
-- vim.opt.cursorline = true
-- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2a2a2a', blend = 20 })
-- vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })

-- Set global defaults for spaces
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2      -- Tab width
vim.opt.shiftwidth = 2   -- Indent width
vim.opt.softtabstop = 2  -- Backspace removes full indent

-- Buffer shortcuts
vim.keymap.set('n', '<C-s>', ':w <CR>')
vim.keymap.set('n', '<leader><Tab>', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader><S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bx', ':bd<CR>', { desc = 'Close buffer' })

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


-- Show diagnostics on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- Refactor/rename
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

-- PYTHON
vim.g.python3_host_prog = "/usr/local/bin/python"

vim.opt.clipboard = "unnamedplus"

local local_config = vim.secure.read(".nvim.lua")
if local_config then
  loadstring(local_config)()
end
