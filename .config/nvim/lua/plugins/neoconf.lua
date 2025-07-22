return {
  "folke/neoconf.nvim",
  priority = 1000,
  config = function()
    require('neoconf').setup()
  end,
}
