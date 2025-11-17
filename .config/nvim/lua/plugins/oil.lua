return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  config = function()
    require("oil").setup({
      float = {
        border = "rounded",
        win_options = {
          winhl = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"] = "actions.close",
    -- Yank full absolute path
    ["gy"] = {
      desc = "Yank absolute path",
      callback = function()
        local oil = require("oil")
        local path = oil.get_current_dir()
        vim.fn.setreg('+', path)
        vim.notify("Yanked: " .. path)
      end,
    },
--     Yank relative path to previous buffer
["gr"] = {
  desc = "Yank relative path", 
  callback = function()
    local oil = require("oil")
    local oil_dir = vim.fn.fnamemodify(oil.get_current_dir(), ':p')
    
    -- Get the alternate buffer (simpler approach)
    local alt_buf = vim.fn.bufnr('#')
    local source_buf = nil
    
    if alt_buf ~= -1 and vim.api.nvim_buf_is_valid(alt_buf) then
      local name = vim.api.nvim_buf_get_name(alt_buf)
      if name ~= '' and not name:match('^oil://') then
        source_buf = alt_buf
      end
    end
    
    if not source_buf then
      vim.notify("No source buffer found")
      return
    end
    
    local source_file = vim.api.nvim_buf_get_name(source_buf)
    local current_dir = vim.fn.fnamemodify(source_file, ':p:h')
    
    -- Split paths into parts
    local current_parts = vim.split(current_dir, '/', {plain=true})
    local oil_parts = vim.split(oil_dir:gsub('/$', ''), '/', {plain=true})
    
    -- Find common prefix
    local common = 0
    for i = 1, math.min(#current_parts, #oil_parts) do
      if current_parts[i] == oil_parts[i] then
        common = i
      else
        break
      end
    end
    
    -- Build relative path
    local ups = #current_parts - common
    local downs = {}
    for i = common + 1, #oil_parts do
      table.insert(downs, oil_parts[i])
    end
    
    local relative
    if ups == 0 and #downs == 0 then
      relative = '.'
    else
      local path_parts = {}
      for _ = 1, ups do
        table.insert(path_parts, '..')
      end
      for _, part in ipairs(downs) do
        table.insert(path_parts, part)
      end
      relative = table.concat(path_parts, '/')
    end
    
    vim.fn.setreg('+', relative)
    vim.notify("Yanked relative: " .. relative)
  end,
},
  }
  })
    vim.keymap.set('n', '<leader>e', '<Cmd>Oil --float<CR>')
  end,
}
