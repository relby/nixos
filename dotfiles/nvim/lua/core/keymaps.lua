-- Center the window after certain movements
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Put cursor in place when joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Format the file with lsp
vim.keymap.set('n', '<A-f>', function()
    vim.lsp.buf.format()
end)

-- Select all file
vim.keymap.set('n', '<leader>sa', 'GVgg')

-- Resize windows
vim.keymap.set('n', '<A-Left>', '<C-w><')
vim.keymap.set('n', '<A-Right>', '<C-w>>')
vim.keymap.set('n', '<A-Down>', '<C-w>-')
vim.keymap.set('n', '<A-Up>', '<C-w>+')

-- Paste and copy from clipboard
vim.keymap.set('n', '<Space>p', 'o<Esc>"+p')
vim.keymap.set('n', '<Space>P', 'O<Esc>"+P')
vim.keymap.set('x', '<Space>p', '"+p')
vim.keymap.set('x', '<Space>P', '"+P')
vim.keymap.set({ 'n', 'x' }, '<Space>y', '"+y')

-- Convenient keymaps to exit insert mode
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'Kj', '<Esc>')
vim.keymap.set('i', 'KJ', '<Esc>')

-- Delete word in insert mode
vim.keymap.set('i', '<A-BS>', '<C-w>')
-- Enter normal mode in terminal
vim.keymap.set('t', '<C-v>', [[<C-\><C-n>]])

-- Move selected lines up and down
vim.keymap.set('v', 'J', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', 'K', [[:m '<-2<CR>gv=gv]])

-- Prevent canceling virtual mode when indenting
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')

-- Substitute all occurrences of the word under the cursor:
vim.keymap.set('n', '<leader>ss', [[:%s/\<<C-r><C-w>\>/]])

-- Open up Undotree
vim.keymap.set('n', '<leader>u', function() vim.cmd('UndotreeToggle') end)
