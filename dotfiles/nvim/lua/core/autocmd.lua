-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('HighlightOnYank', { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = vim.fn['hlexists']('HighlightedyankRegion') > 0
                and 'HighlightedyankRegion'
                or 'Visual', -- or 'IncSearch'
            timeout = 50,
            on_visual = false,
        })
    end,
})
