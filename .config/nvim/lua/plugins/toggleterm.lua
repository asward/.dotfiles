local function toggle_float_at_buffer()
  local Terminal = require('toggleterm.terminal').Terminal
  local path = vim.fn.expand('%:p:h') -- Get current buffer's directory

  -- Find terminal #2
  local terms = require('toggleterm.terminal').get_all()
  local term_2 = nil
  for _, term in pairs(terms) do
    if term.id == 2 then
      term_2 = term
      break
    end
  end

  if term_2 then
    if term_2:is_open() then
      -- Terminal is open - just close and return
      term_2:close()
      return
    else
      -- Terminal exists but not open - check path
      if term_2.dir == path then
        -- Same directory - just toggle
        term_2:toggle()
        return
      else
        -- Different directory - shutdown and create new
        term_2:shutdown()
      end
    end
  end

  -- Create new floating terminal at buffer location with ID 2
  local float_term = Terminal:new({
    count = 2,
    direction = 'float',
    dir = path,
    close_on_exit = false,
    float_opts = {
      border = 'curved',
      width = math.floor(vim.o.columns * 0.8),
      height = math.floor(vim.o.lines * 0.8),
    }
  })

  float_term:toggle()
end



return {
  'akinsho/toggleterm.nvim',
  -- event = "VeryLazy",
  -- cmd = "ToggleTerm",
  keys = {

    { '<leader>tr', '<cmd>:1ToggleTerm direction=float<CR>', mode = { 'n', 'i', 't' } },
    { '<leader>tw', toggle_float_at_buffer,                  mode = { 'n', 'i', 't' }, desc = 'Toggle float terminal at buffer location' },
    --    { '<M-F2>',     '<cmd>:3ToggleTerm direction=vertical size=100<CR>',  mode = { 'n', 't' } },
    --    { '<M-F3>',     '<cmd>:4ToggleTerm direction=float<CR>',              mode = { 'n', 't' } },
    --    { '<leader>gl', function() end,                                       mode = { 'n', 't' } },
    --    { '<leader>fr', function() end,                                       mode = { 'n', 't' } },
  },
  version = "*",
  config = function()
    require('toggleterm').setup({

      start_in_insert = true,
      terminal_mappings = true,
      -- direction = 'float',
      -- shell = "pwsh.exe -NoLogo -NoProfile",
      --       shell = "pwsh.exe -NoLogo",
      auto_scroll = true,
      -- persist_mode = true,
      persist_size = true,
      close_on_exit = true,
    })
    -- function _lazygit_toggle()
    -- local Terminal = require('toggleterm.terminal').Terminal
    -- local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
    -- lazygit:toggle()
    -- end

    -- vim.keymap.set({ 'n', 't' }, '<leader>gl', function() _lazygit_toggle() end)
    --     vim.keymap.set({ 'n', 't' }, '<leader>gl', function()
    --       local terminal = require('toggleterm.terminal').Terminal
    --       local lazygit = terminal:new({ cmd = 'lazygit', hidden = true, direction = 'float' })
    --       lazygit:toggle()
    --     end, { desc = "LazyGit" })
    --
    --     vim.keymap.set({ 'n', 't' }, '<leader>fr', function()
    --       local terminal = require("toggleterm.terminal").Terminal
    --       local scooter = terminal:new({ cmd = "scooter", hidden = true, direction = "float" })
    --       scooter:toggle()
    --     end, { desc = "Find and Replace" })
  end
}
