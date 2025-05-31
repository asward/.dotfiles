return {
  'nvimdev/guard.nvim',
  lazy = false,
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = function()
    local ft = require('guard.filetype')
    ft('markdown,typescript,javascript,typescriptreact'):fmt('prettier')
  end,
}

