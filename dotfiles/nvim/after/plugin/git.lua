require('gitsigns').setup({
    -- Try to configure it
})

local opts = { silent = true }

vim.keymap.set('n', 'gs', ':Gitsigns preview_hunk<CR>', opts)
vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', opts)
vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', opts)
