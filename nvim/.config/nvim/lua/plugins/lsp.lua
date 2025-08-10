local function setup()
    require("lazydev").setup({
        library = {
            "lazy.nvim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" }, },
        },
        integrations = {
            lspconfig = true,
            cmp = true,
            coq = false,
        },

        enabled = function(root_dir)
            return (not vim.uv.fs_stat(root_dir .. "/.luarc.json")) and
                (vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled)
        end,
    })

    local lspconfig = require("lspconfig")
    --Enable (broadcasting) snippet capability for completion
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.tailwindcss.setup({
        ft = { "typescriptreact", "javascriptreact", "vue", "svelte", "html" }
    })

    lspconfig.lua_ls.setup({
        settings = {
            Lua = {}
        }
    })

    lspconfig.clangd.setup({
        capabilities = capabilities
    })

    lspconfig.gopls.setup({
        settings = {
            gopls = {
                staticcheck = true,
            }
        }
    })

    lspconfig.basedpyright.setup({})

    lspconfig.jdtls.setup({
        root_dir = function()
            local dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
            if dir == nil then
                dir = vim.fn.getcwd()
            end
            return dir
        end
    })

    lspconfig.cssls.setup({
        capabilities = capabilities,
    })

    lspconfig.ts_ls.setup({})

    lspconfig.yamlls.setup({
        telemetry = false
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

    lspconfig.docker_compose_language_service.setup({})

    lspconfig.dockerls.setup({
        settings = {
            docker = {
                languageserver = {
                    formatter = {
                        ignoreMultilineInstructions = true,
                    },
                },
            }
        }
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
