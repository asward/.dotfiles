return {
  "folke/neoconf.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require('neoconf').setup({
      -- Try enabling debug
      debug = true,
    })
  end,
}
