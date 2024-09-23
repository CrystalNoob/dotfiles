local function setup()
	require("aerial").setup({
		extensions = {
			aerial = {
				-- How to format the symbols
				format_symbol = function(symbol_path, filetype)
					if filetype == "json" or filetype == "yaml" then
						return table.concat(symbol_path, ".")
					else
						return symbol_path[#symbol_path]
					end
				end,
				-- Available modes: symbols, lines, both
				show_columns = "both",
			},
		},
	})

	require("telescope").setup({
		extension = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			}
		}
	})

	require("telescope").load_extension("aerial")
	require("telescope").load_extension("fzf")

	local builtin = require("telescope.builtin")
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			build = "make",
		},
	},
	opts = setup
}
