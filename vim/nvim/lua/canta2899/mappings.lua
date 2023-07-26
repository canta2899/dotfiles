-- n, v, i, t = mode names

vim.keymap.set('i', '<C-b>', '<ESC>^i')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', "<C-h>", "<Left>")
vim.keymap.set('i', "<C-l>", "<Right>")
vim.keymap.set('i', "<C-j>", "<Down>")
vim.keymap.set('i', "<C-k>", "<Up>")

vim.keymap.set('n', '<Esc>', ':noh <CR>', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<leader>n', '<cmd> set nu! <CR>')
vim.keymap.set('n', '<leader>rn', '<cmd> set rnu! <CR>')
vim.keymap.set('n', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set('n', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'd', '\"_d')
vim.keymap.set('v', 'd', '\"_d')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'è', '$')
vim.keymap.set('v', 'è', '$')
vim.keymap.set('n', 'à', '^')
vim.keymap.set('v', 'à', '^')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
vim.keymap.set('n', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set('n', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>')
vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format() end)

vim.keymap.set('t', '<C-x>', vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true))

vim.keymap.set('v', '<Up>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set('v', '<Down>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

vim.keymap.set('x', 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set('x', 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set('x', 'p', 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true})

