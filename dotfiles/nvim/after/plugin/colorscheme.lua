require('tokyonight').setup({
    style = 'storm',
    styles = {
        comments = {
            italic = false,
        },
        keywords = {
            italic = false,
        },
    },
})

require('catppuccin').setup({
    flavour = 'mocha',
    no_italic = true,
})

-- [[ Default colorscheme ]]
-- Tokyonight
vim.cmd('colorscheme tokyonight')

-- Gruvbox
-- vim.o.background = 'dark'
-- vim.cmd('colorscheme gruvbox')

-- Catpussin
-- vim.cmd('colorscheme catppuccin')
