local ls = require("luasnip")

ls.snippets = {
    all = {

    },
    lua = {
        ls.parser.parse_snippet("f", "local $1 = function($2)\n    $0\nend")
    }
}

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)

vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end)
