local function setup()
	require("gitsigns").setup({
		current_line_blame = true,
	})
end

return {
	"lewis6991/gitsigns.nvim",
	opts = setup
}
