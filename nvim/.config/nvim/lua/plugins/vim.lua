local diag = vim.diagnostic
local set = vim.opt

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.number = true
set.scrolloff = 10
set.cursorline = true
set.termguicolors = true
set.clipboard = "unnamedplus"
diag.config({
    -- virtual_lines = true,
    virtual_text = true
})

return {}
