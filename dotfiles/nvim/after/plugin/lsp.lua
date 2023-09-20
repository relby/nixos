require('mason').setup({
    ui = {
        border = 'single',
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
})
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
    ensure_installed = {
        'lua_ls',
        'rust_analyzer',
        'clangd',
        'pyright',
        'tsserver',
        'rnix'
    },
})

local on_attach = function(client, buffer)
    local opts = { buffer = buffer, remap = false }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, opts)

    -- Diagnostics
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

mason_lspconfig.setup_handlers({
    -- Default configurations for all installed servers
    function(server_name)
        require('lspconfig')[server_name].setup({
            on_attach = on_attach
        })
    end,
    -- Configurations for specific servers
    ['lua_ls'] = function()
        require('lspconfig')['lua_ls'].setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        enable = true,
                        globals = { 'vim' }
                    },
                },
            },
        })
    end,
    ['rust_analyzer'] = function()
        require("rust-tools").setup({
            server = {
                on_attach = on_attach,
            },
        })
    end,
    ['clangd'] = function()
        require('lspconfig')['clangd'].setup({
            on_attach = on_attach,
            init_options = {
                fallbackFlags = {
                    '-std=c++17',
                    '-pedantic',
                    '-Wall',
                    '-Wextra',
                    '-Wswitch-enum',
                },
            },
        })
    end,
    ['pyright'] = function()
        -- Set virtual environment inside poetry project
        local path = require('lspconfig.util').path
        local venvPath
        vim.fn.jobstart(
            'poetry env info --path',
            {
                cwd = vim.fn.getcwd(),
                stdout_buffered = true,
                on_exit = function(_, exit_code)
                    if exit_code == 0 then
                        vim.env.VIRTUAL_ENV = venvPath
                        vim.env.PATH = path.join(vim.env.VIRTUAL_ENV, 'bin:') .. vim.env.PATH
                    end
                end,
                on_stdout = function(_, data)
                    venvPath = data[1]
                end,
            }
        )
        -- Pyright settings
        require('lspconfig')['pyright'].setup({
            on_attach = on_attach,
        })
    end
})

--[[ UI Settings ]]
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = 'single',
    }
)
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = 'single',
    }
)
-- Diagnostics
vim.diagnostic.config({
    float = {
        border = 'single'
    }
})

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })
