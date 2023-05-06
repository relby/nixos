local lspkind = require('lspkind')
lspkind.init()

local cmp = require('cmp')
local luasnip = require('luasnip')

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    mapping = {
        ['<C-f>'] = cmp.mapping.confirm({ select = true }),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping({
            i = function()
                if cmp.visible() then
                    cmp.abort()
                else
                    cmp.complete()
                end
            end,
            c = function()
                if cmp.complete() then
                    cmp.close()
                else
                    cmp.complete()
                end
            end
        }),

        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    -- Note: Sorted by priority (descending)
    -- config fields: keyword_length, priority, max_item_count
    sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'cmp_tabnine', keyword_length = 5 },
        { name = 'buffer', keyword_length = 5 },
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[lsp]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                cmp_tabnine = "[TabNine]",
            },
        }),
    },
    experimental = {
        ghost_text = true,
    },
    window = {
        -- Use cmp.config.window.bordered() to see
        -- all default window settings
        completion = {
            border = 'single'
        },
        documentation = {
            border = 'single'
        },
    }
})
