-- lua/log-viewer.lua
local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local previewers = require('telescope.previewers')

-- Store last selected log file
local last_selected_log = nil

-- Custom previewer for tailing log files
local log_previewer = previewers.new_buffer_previewer({
  title = "Log Tail",
  define_preview = function(self, entry, status)
    local file_path = entry.value
    if not file_path or file_path == "" then
      return
    end
    
    local cmd = { 'tail', '-n', '50', file_path }
    
    vim.fn.jobstart(cmd, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        if data and self.state.bufnr and vim.api.nvim_buf_is_valid(self.state.bufnr) then
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, data)
          vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'log')
        end
      end,
    })
  end,
})

-- Custom log file picker
local function log_file_picker(opts)
  opts = opts or {}
  
  -- Get log files first to find default selection
  local log_files = vim.fn.systemlist("find . -name '*.log' -type f")
  local default_idx = 1
  
  if last_selected_log and #log_files > 0 then
    for i, file in ipairs(log_files) do
      if file == last_selected_log then
        default_idx = i
        break
      end
    end
  end
  
  pickers.new(opts, {
    prompt_title = "Log Files",
    finder = finders.new_table({
      results = log_files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    default_selection_index = default_idx,
    previewer = log_previewer,
    sorter = conf.file_sorter(opts),
    -- Remove default_selection_index line since we set it above
    attach_mappings = function(prompt_bufnr, map)
      -- Track initial selection and any changes
      local function update_selection()
        local selection = action_state.get_selected_entry()
        if selection then
          last_selected_log = selection.value
        end
      end
      
      -- Track initial selection
      vim.defer_fn(update_selection, 100)
      
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        last_selected_log = selection.value
        actions.close(prompt_bufnr)
        vim.cmd('edit ' .. selection.value)
      end)
      
      -- Track selection changes
      map('i', '<C-j>', function()
        actions.move_selection_next(prompt_bufnr)
        update_selection()
      end)
      
      map('i', '<C-k>', function()
        actions.move_selection_previous(prompt_bufnr)
        update_selection()
      end)
      
      map('n', 'j', function()
        actions.move_selection_next(prompt_bufnr)
        update_selection()
      end)
      
      map('n', 'k', function()
        actions.move_selection_previous(prompt_bufnr)
        update_selection()
      end)
      
      -- Track cursor moved events
      map('i', '<Up>', function()
        actions.move_selection_previous(prompt_bufnr)
        update_selection()
      end)
      
      map('i', '<Down>', function()
        actions.move_selection_next(prompt_bufnr)
        update_selection()
      end)
      
      return true
    end,
  }):find()
end

-- Export the function
local M = {}

M.log_file_picker = log_file_picker

return M
