return {'sindrets/diffview.nvim',
config = function()
  require('diffview').setup({
  enhanced_diff_hl = true, -- better syntax highlighting
  view = {
    merge_tool = {
      layout = "diff3_mixed", -- shows base/local/remote labels
    }
  }
})
end,
}
