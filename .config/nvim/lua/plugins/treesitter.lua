return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main doesn't support lazy-loading
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        ts.install({
            "markdown",
            "markdown_inline",
            "python",
            "javascript",
            "typescript",
            "html",
            "css",
            "lua",
            "json",
            "yaml",
            "bash",
            "c",
            "cpp",
            "rust",
            "go",
            "ruby",
            "vim",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then
                    return
                end

                -- rough auto_install replacement
                if not pcall(vim.treesitter.start, args.buf, lang) then
                    if vim.tbl_contains(ts.get_available(), lang) then
                        ts.install(lang):await(function()
                            pcall(vim.treesitter.start, args.buf, lang)
                        end)
                    end
                end

                -- indent (uncomment to enable)
                -- vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
