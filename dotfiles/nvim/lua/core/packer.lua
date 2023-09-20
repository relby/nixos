local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup({ function(use, use_rocks)
    use('wbthomason/packer.nvim')
    -- Colorschemas
    use('folke/tokyonight.nvim')
    use('ellisonleao/gruvbox.nvim')
    use('EdenEast/nightfox.nvim')
    use('rose-pine/neovim')
    use({ "catppuccin/nvim", as = "catppuccin" })
    -- Development
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    })

    use('nvim-treesitter/nvim-treesitter-context')
    use('nvim-treesitter/nvim-treesitter')
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
    })
    use('nvim-telescope/telescope-ui-select.nvim')
    use('nvim-telescope/telescope-file-browser.nvim')
    use('folke/zen-mode.nvim')
    use('numToStr/Comment.nvim')
    use({
        'akinsho/toggleterm.nvim',
        tag = '*',
    })
    -- LSP
    use('neovim/nvim-lspconfig')
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use('simrat39/rust-tools.nvim')
    -- Completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lua')
    use('hrsh7th/cmp-nvim-lsp')
    use('saadparwaiz1/cmp_luasnip')
    use('onsails/lspkind.nvim')
    use({ 'tzachar/cmp-tabnine', run = './install.sh' })
    -- Snippets
    use('L3MON4D3/LuaSnip')

    -- Cool stuff
    use('eandrju/cellular-automaton.nvim')
    use('j-hui/fidget.nvim')
    -- UI
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
    use('lewis6991/gitsigns.nvim')
    use('mbbill/undotree')
    -- A little annoying but maybe I'll use it later
    -- use('rcarriga/nvim-notify')

    -- Luarocks
    -- TODO: Figure out how to use Luarocks
    -- use_rocks('LuaSocket')

    if packer_bootstrap then
        require('packer').sync()
    end
end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'packer.lua',
    group = packer_group,
    command = 'source <amatch> | PackerCompile',
})
