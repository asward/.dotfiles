
return {
     'echasnovski/mini.nvim', 
     version='*',
     dependencies = {
       "nvim-tree/nvim-web-devicons",
     },
     config = function()
	require('mini.icons').setup()
	require('mini.files').setup()
	--require('mini.map').setup()
	require('mini.animate').setup()
	--require('mini.tabline').setup()
	--require('mini.statusline').setup()
  	

	--vim.keymap.set('n', '<Leader>mc', MiniMap.close)
	--vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
	--vim.keymap.set('n', '<Leader>mo', MiniMap.open)
	--vim.keymap.set('n', '<Leader>mr', MiniMap.refresh)
	--vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side)
	--vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)

     end,
}
