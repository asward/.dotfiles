local M = { items = {}, unread = 0, max_level = 0, max_items = 500 }
local L = vim.log.levels
local names = { [0] = "TRACE", "DEBUG", "INFO", "WARN", "ERROR" }
local hl = { [L.ERROR] = "DiagnosticError", [L.WARN] = "DiagnosticWarn", [L.INFO] = "DiagnosticInfo" }

local function refresh()
    vim.schedule(function()
        pcall(function()
            require("lualine").refresh()
        end)
    end)
end

function M.notify(msg, level, opts)
    if type(level) == "string" then
        level = L[level:upper()]
    end
    level, opts = level or L.INFO, opts or {}
    table.insert(M.items, { time = os.date("%H:%M:%S"), level = level, title = opts.title, msg = tostring(msg) })
    if #M.items > M.max_items then
        table.remove(M.items, 1)
    end
    if level >= L.INFO then
        M.unread = M.unread + 1
        M.max_level = math.max(M.max_level, level)
    end
    refresh()
end

function M.open()
    local lines, heads = {}, {}
    for i = #M.items, 1, -1 do
        local it = M.items[i]
        heads[#lines] = it.level
        table.insert(lines, ("%s %-5s %s"):format(it.time, names[it.level] or "?", it.title or ""))
        for _, l in ipairs(vim.split(it.msg, "\n", { plain = true })) do
            table.insert(lines, "  " .. l)
        end
        table.insert(lines, "")
    end

    local native = vim.split(vim.fn.execute("messages"), "\n", { trimempty = true })
    if #native > 0 then
        table.insert(lines, "── :messages ──")
        vim.list_extend(lines, native)
    end
    if #lines == 0 then
        lines = { "No alerts" }
    end

    vim.cmd("botright 15split")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable, vim.bo[buf].bufhidden, vim.bo[buf].filetype = false, "wipe", "alerts"

    local ns = vim.api.nvim_create_namespace("alerts")
    for row, lvl in pairs(heads) do
        vim.api.nvim_buf_set_extmark(buf, ns, row, 0, { end_col = #lines[row + 1], hl_group = hl[lvl] or "Comment" })
    end

    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf })
    vim.keymap.set("n", "C", function()
        M.items = {}
        vim.cmd("messages clear | close")
    end, { buffer = buf, desc = "Clear alerts" })

    M.unread, M.max_level = 0, 0
    refresh()
end

local component = {
    function()
        return "󰂚 " .. M.unread
    end,
    cond = function()
        return M.unread > 0
    end,
    color = function()
        local fg = vim.api.nvim_get_hl(0, { name = hl[M.max_level] or "DiagnosticInfo", link = false }).fg
        return fg and { fg = ("#%06x"):format(fg) } or nil
    end,
    on_click = function()
        M.open()
    end,
}

return {
    "alerts",
    virtual = true,
    lazy = false,
    priority = 1000,
    keys = {
        { "<leader>na", M.open, desc = "Alerts history" },
    },
    config = function()
        M.lualine = component
        package.loaded["alerts"] = M
        vim.notify = M.notify
    end,
}
