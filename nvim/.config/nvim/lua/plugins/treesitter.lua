local function setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "css", "cpp", "html", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
            enable = true,
            disable = function(_, buf)
                local max_filesize = 1024 * 1024 -- 1 MB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        modules = {},
    })

    require("nvim-autopairs").setup({
        disable_filetype = {
            "TelescopePrompt",
            "vim",
        },
    })
    require("nvim-ts-autotag").setup()
    require("Comment").setup()
end

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    dependencies = {
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
        },
        "windwp/nvim-ts-autotag",
        "numToStr/Comment.nvim",
    },
    opts = setup
}
