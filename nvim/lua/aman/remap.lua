-- fish doesn't always work
vim.g["shell"] = "/bin/bash"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- search result centered plzz
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'g*', 'g*zz')

-- magicccc
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', "%s/", "%sm/")

vim.keymap.set('v', '<leader>h', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>')

-- Jump to start and end of line using the home row keys
vim.cmd [[
    map H ^
    map L $
]]

--clipboard integration
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--arrow keys switch the buffers
vim.keymap.set('n', '<left>', ':bp<CR>')
vim.keymap.set('n', '<right>', ':bn<CR>')

--quickfix list switch
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- because for some reason Ctrl-c is not esc in normal mode
vim.keymap.set('i', '<C-c>', '<ESC>')

-- switch to alst buffer
vim.keymap.set('n', '<leader><leader>', '<c-^>')

-- shows john cena characters
vim.keymap.set('n', '<leader>,', ':set invlist<cr>')
