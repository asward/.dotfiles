vim.opt.termguicolors = true
vim.cmd.colorscheme('habamax')


-- LSP
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

-- PLUGINS
require("config.lazy")

-- WORKSPACE
local project_config = vim.fn.getcwd() .. "/.nvimrc.lua"
if vim.fn.filereadable(project_config) == 1 then
  dofile(project_config)
end

vim.api.nvim_set_hl(0, 'FloatBorder', { fg = 'white', bg = 'NONE' })
vim.opt.number = true
vim.opt.updatetime = 250
vim.opt.relativenumber = true

vim.opt.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = {
  eol = "↴",
  --  tab = "│⋅",
  --  trail = "•",
  --  extends = "❯",
  --  precedes = "❮",
}

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
--
-- -- CursorLine
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#2a2a2a', blend = 20 })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })

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
    local clients = vim.lsp.get_clients({ bufnr = 0 })
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


-- PYTHON
vim.g.python3_host_prog = "/usr/local/bin/python"

vim.opt.clipboard = "unnamedplus"
