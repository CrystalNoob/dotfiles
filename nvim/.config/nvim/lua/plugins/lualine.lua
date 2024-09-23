local function setup()

	vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>')
	vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>')
	vim.keymap.set('n', '<leader>bc', '<cmd>bd<CR>')

	require("bufferline").setup({
		options = {
			close_command = nil,
			buffer_close_icon = '',
			close_icon = '',
			diagnostics = "nvim_lsp",
			hover = { enabled = false },
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true
				}
			}
		}
	})

	require("lualine").setup({
		options = {
			theme = bubbles_theme,
			component_separators = '',
			section_separators = { left = '', right = '' },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = '' }, right_padding = 2 } },
			lualine_b = { "filename", "branch", "diff", "diagnostics" },
			lualine_c = { "%=" },
			lualine_x = { "encoding", "fileformat" },
			lualine_y = { "filetype", "progress" },
			lualine_z = {
				{ "location", separator = { right = '' }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{
			"akinsho/bufferline.nvim",
			version = '*',
			dependencies = "nvim-tree/nvim-web-devicons",
		},
		"nvim-tree/nvim-web-devicons",
	},
	opts = setup,
}
