local function setup()
	require("catppuccin").setup({
		flavour = "mocha",
		transparent_background = false,
	})
	require("catppuccin").load()

	local hooks = require("ibl.hooks")
	local highlightBlur = { "IndentBlur" }
	local highlightFocus = { "IndentFocus" }

	hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		vim.api.nvim_set_hl(0, "IndentBlur", { fg = "#555555" })
		vim.api.nvim_set_hl(0, "IndentFocus", {fg = "#E06C75" })
	end)

	require("ibl").setup({
		indent = {
			highlight = highlightBlur
		},
		scope = {
			highlight = highlightFocus
		}
	})

	require("nvim-highlight-colors").setup({})
end

return {
	{
		"catppuccin/nvim",
		dependencies = {
			"lukas-reineke/indent-blankline.nvim"
		},
		name = "catppuccin",
		priority = 1000,
		opts = setup,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {
			enable_tailwind = true,
		}
	},
}
