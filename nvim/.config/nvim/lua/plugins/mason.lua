local function setup()
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			}
		}
	})
end

return {
	"williamboman/mason.nvim",
	opts = setup,
}
