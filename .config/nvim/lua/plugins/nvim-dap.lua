return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require("dap")
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue/Start debugging" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })

    vim.fn.sign_define('DapBreakpoint', {
      text = '●',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = '✘',
      texthl = 'DapBreakpointRejected',
      linehl = '',
      numhl = ''
    })
    -- Set colors
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' })
  end
}
