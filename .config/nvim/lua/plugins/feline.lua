return {
  "feline-nvim/feline.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
	require('feline').setup()
	default = require('feline.default_components').statusline.icons	

	-- Window number component
	local window_number = {
	  provider = function()
	    return ' ' .. vim.fn.winnr() .. ' '
	  end,
	  hl = { fg = 'white', bg = 'blue', style = 'bold' },
	  right_sep = ' ',
	}
	
	-- Insert window number as first component in active left section
	table.insert(default.active[1], 1, window_number)
	-- Insert window number as first component in inactive left section
	table.insert(default.inactive[1], 1, window_number)
	
    -- Window jump keybindings
    for i = 1, 9 do
      vim.keymap.set('n', '<leader>' .. i, i .. '<C-w>w', { desc = 'Jump to window ' .. i })
    end

  end,
}
