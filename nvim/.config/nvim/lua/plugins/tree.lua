local function setup()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

    require("nvim-tree").setup()
end

return {
    "nvim-tree/nvim-tree.lua",
    config = setup,
}
