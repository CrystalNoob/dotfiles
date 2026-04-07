local function setup()
    require("nvim-treesitter").install { "c", "cpp", "gitconfig", "go", "gomod", "gosum", "lua", "markdown", "markdown_inline", "zsh" }

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
    branch = "main",
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
