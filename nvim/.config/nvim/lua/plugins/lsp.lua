local function setup()
    require("lazydev").setup({
        library = {
            "lazy.nvim",
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
        integrations = {
            lspconfig = true,
            cmp = true,
            coq = false,
        },

        enabled = function(root_dir)
            return (not vim.uv.fs_stat(root_dir .. "/.luarc.json"))
                and (vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled)
        end,
    })

    local function lsp(name, opts)
        vim.lsp.config(name, opts or {})
        vim.lsp.enable(name)
    end

    --Enable (broadcasting) snippet capability for completion
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lsp("tailwindcss", {
        ft = { "typescriptreact", "javascriptreact", "vue", "svelte", "html" }
    })

    lsp("lua_ls", {
        settings = {
            Lua = {}
        }
    })

    lsp("clangd", {
        capabilities = capabilities
    })

    lsp("gopls", {
        settings = {
            gopls = {
                staticcheck = true,
            }
        }
    })

    lsp("basedpyright")

    lsp("jdtls", {
        root_dir = function()
            local dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])
            if dir == nil then
                dir = vim.fn.getcwd()
            end
            return dir
        end
    })

    lsp("cssls", {
        capabilities = capabilities,
    })

    lsp("ts_ls")

    lsp("yamlls", {
        telemetry = false
    })

    lsp("html", {
        capabilities = capabilities,
    })

    lsp("jsonls", {
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

    lsp("docker_compose_language_service")

    lsp("dockerls", {
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
    config = setup,
}
