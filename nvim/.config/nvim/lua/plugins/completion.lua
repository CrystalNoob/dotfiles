local function setup()
    -- luasnip setup
    local luasnip = require("luasnip")
    luasnip.setup()

    -- nvim-cmp setup
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
            ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0,
            },
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                cmp.config.compare.offset,    -- we still want offset to be higher to order after 3rd letter
                cmp.config.compare.score,     -- same as above
                cmp.config.compare.sort_text, -- add higher precedence for sort_text, it must be above `kind`
                cmp.config.compare.recently_used,
                cmp.config.compare.kind,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        completion = {
            completeopt = 'menu,menuone',
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "nvim_lsp_signature_help" },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local color_item = require("nvim-highlight-colors").format(entry, { kind = vim_item.kind })
                local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                local strings = vim.split(kind.kind, "%s", { trimempty = true })

                kind.kind = " " .. (strings[1] or "") .. " "
                kind.menu = "    (" .. (strings[2] or "") .. ")"

                if color_item.abbr_hl_group then
                    kind.kind_hl_group = color_item.abbr_hl_group
                    kind.kind = color_item.abbr
                end
                return kind
            end,
        },
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    require 'lsp_signature'.setup({
        bind = true,
        doc_lines = 10,
        hint_enable = true,
        handler_opts = {
            border = "none"
        }
    })
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        {
            "ray-x/lsp_signature.nvim",
            event = "VeryLazy",
            opts = {},
        },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            dependencies = { "rafamadriz/friendly-snippets" },
        },
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
    },
    opts = setup
}
