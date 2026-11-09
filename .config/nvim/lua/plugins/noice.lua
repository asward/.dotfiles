return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        cmdline = { enabled = true, view = "cmdline_popup" },
        popupmenu = { enabled = true }, -- completion menu under the floating cmdline
        messages = { enabled = false }, -- native echo area / :messages
        notify = { enabled = false }, -- leaves vim.notify to alerts
        lsp = {
            progress = { enabled = false },
            hover = { enabled = false },
            signature = { enabled = false },
            message = { enabled = false },
        },
    },
}
