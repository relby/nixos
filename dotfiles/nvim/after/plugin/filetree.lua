vim.cmd([[let g:neo_tree_remove_legacy_commands = 1]])

require('neo-tree').setup({
    close_if_last_window = true,
    popup_border_style = 'single',
    window = {
        position = 'right',
    },
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_by_name = {
                '.git',
            }
        },
    },
})
local opts = { silent = true }

vim.keymap.set('n', '<C-n>', function() vim.cmd('NeoTreeFloatToggle') end, opts)
vim.keymap.set('n', '<C-b>', function() vim.cmd('NeoTreeRevealToggle') end, opts)
