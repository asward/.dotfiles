local builtin = require('telescope.builtin')
local log_viewer = require('telescope-log-viewer')

local function find_files_with_path_regex()
	require('telescope.builtin').live_grep({
		prompt_title = "Find Files (Path Regex)",
		glob_pattern = "",
		additional_args = function()
			return { "--iglob", "**/*" }
		end,
	})
end

local function buffer_finder_with_delete()
	require('telescope.builtin').buffers({
		attach_mappings = function(prompt_bufnr, map)
			map('n', 'x', function()
				local selection = require('telescope.actions.state').get_selected_entry()
				if selection then
					vim.api.nvim_buf_delete(selection.bufnr, { force = false })
					require('telescope.actions').delete_buffer(prompt_bufnr)
				end
			end)
			return true
		end,
	})
end

-- Global keybindings to trigger telescope
vim.keymap.set('n', '<leader>ff', function()
	require("telescope.builtin").find_files({ hidden = true, initial_mode = "insert" })
end, { desc = 'Telescope find files (include hidden)' })

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', buffer_finder_with_delete, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fp', find_files_with_path_regex, { desc = 'Find files with path regex' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').treesitter, { desc = 'Find functions (treesitter)' })
vim.keymap.set('n', '<leader>fl', log_viewer.log_file_picker, { desc = 'Browse log files' })

return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require('telescope').setup({
			defaults = {
				initial_mode = "normal",
				mappings = {
					i = {
						["q"] = require('telescope.actions').close,
					},
					n = {
						["q"] = require('telescope.actions').close,
					},
				},
			},
		})
	end,
}
