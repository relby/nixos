-- Leader
vim.g.mapleader = ','
-- Ignore files
vim.opt.wildignore:append({ '__pycache__', '*.o', '*.pyc', 'Cargo.lock' })
-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- Do not wrap lines
vim.opt.wrap = false
-- Nice appearance
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·' }
vim.opt.colorcolumn = '80'
-- Managing cache
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.cache/nvim/undodir'
vim.opt.undofile = true
-- Searching
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Split always in bottom right
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Nice terminal colors
vim.o.termguicolors = true
-- How to call these?
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
