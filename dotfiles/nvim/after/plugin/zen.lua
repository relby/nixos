require('zen-mode').setup({
    window = {
        width = 95,
        options = {
            number = true,
            relativenumber = true,
        },
    },
})

vim.keymap.set("n", "<leader>zz", function()
    vim.cmd('ZenMode')
    vim.opt.wrap = false
end)
