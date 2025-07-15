return {
 "rcarriga/nvim-dap-ui",
  config = function()
		require('dapui').setup()
		vim.keymap.set('n', '<leader>du', function() require('dapui').toggle({}) end)
		vim.keymap.set('n', '<leader>dw', function() require('dapui').toggle({}) end)
		vim.keymap.set('n', '<leader>dw', function()
		  require('dapui').open({ layout = 1, reset = true })
		  -- Focus on watches window
		  vim.cmd('wincmd w')
		end, { desc = 'Open DAP watches' })
		-- local dap, dapui = require("dap"), require("dapui")
		-- dap.listeners.before.attach.dapui_config = function()
		--   dapui.open()
		-- end
		-- dap.listeners.before.launch.dapui_config = function()
		--   dapui.open()
		-- end
		-- dap.listeners.before.event_terminated.dapui_config = function()
		--   dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function()
		--   dapui.close()
		-- end
	end,
  dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
  },
}
