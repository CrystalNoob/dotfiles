local function setup()
	require("lazydev").setup({
		library = {
			"lazy.nvim",
		},
		integrations = {
			lspconfig = true,
			cmp = true,
			coq = false,
		},
		enabled = function(root_dir)
			return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
		end,

		enabled = function(root_dir)
			return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
		end,
	})

	local original_floating = vim.lsp.util.open_floating_preview
	---@diagnostic disable-next-line
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		---@type nil, any
		local buffer, window = original_floating(contents, syntax, opts, ...)

		vim.api.nvim_win_set_option(window, "winhighlight",
			"Normal:CompletionPmenu,FloatBorder:CompletionPmenu,Pmenu:CompletionPmenu,CursorLine:CompletionPmenuSel,Search:CompletionPmenu")
		return buffer, window
	end

	local lspconfig = require("lspconfig")

	lspconfig.tailwindcss.setup({
		ft = { "typescriptreact", "javascriptreact", "vue", "svelte", "html" }
	})

	lspconfig.lua_ls.setup({
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT"
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
						-- Depending on the usage, you mikght want to add additional paths here.
						-- "${3rd}/luv/library"
						-- "${3rd}/busted/library",
					},
					-- or pull in all of "runtimepath". NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file('', true)
				}
			})
		end,
		settings = {
			Lua = {}
		}
	})

	lspconfig.clangd.setup({})

	lspconfig.gopls.setup({})

	lspconfig.pyright.setup({
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off"
				}
			}
		}
	})

	lspconfig.jdtls.setup({
		root_dir = function()
			local dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
			if dir == nil then
				dir = vim.fn.getcwd()
			end
			return dir
		end
	})

	--Enable (broadcasting) snippet capability for completion
	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

	lspconfig.cssls.setup({
		capabilities = capabilities,
	})

	lspconfig.ts_ls.setup({
		capabilities = capabilities,
	})

	lspconfig.html.setup({
		capabilities = capabilities,
	})

	lspconfig.jsonls.setup({
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = {
					enable = true
				}
			},
		},
		capabilities = capabilities,
	})

	lspconfig.docker_compose_language_service.setup({
		capabilities = capabilities,
	})

	lspconfig.dockerls.setup({
		capabilities = capabilities,
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/lazydev.nvim",
		"b0o/schemastore.nvim",
	},
	config = setup
}
