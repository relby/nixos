require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'help',
        'lua',
        'python',
        'rust',
        'javascript',
        'typescript',
        'go',
        'c',
        'cpp',
    },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

--require('treesitter-context').setup({
--})

-- TODO: Configure some mappings for treesitter
