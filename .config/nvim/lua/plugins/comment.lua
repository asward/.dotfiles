-- Using lazy.nvim
return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      toggler = {
        line = '<C-_>', -- Ctrl+/ (terminal sees Ctrl+/ as Ctrl+_)
        block = '<C-_>',
      },
      opleader = {
        line = '<C-_>',
        block = '<C-_>',
      },
    })
  end
}
