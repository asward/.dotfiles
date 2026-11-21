return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "alerts" },
    opts = function()
        return {
            options = {
                theme = "gruvbox_dark",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    { "filename", path = 1 },
                },
                lualine_x = {
                    require("alerts").lualine,
                    {
                        function()
                            return "recording @" .. vim.fn.reg_recording()
                        end,
                        cond = function()
                            return vim.fn.reg_recording() ~= ""
                        end,
                        color = { fg = "#ff9e64" },
                    },
                    "encoding",
                    "fileformat",
                    "filetype",
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        }
    end,
    init = function()
        vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
            callback = function()
                vim.schedule(function()
                    require("lualine").refresh()
                end)
            end,
        })
    end,
}
