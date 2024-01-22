--You will have bad experience for diagnostic messages when it's default 4000.
vim.opt.updatetime = 50
--Completion
--Better completion
--menuone: popup even when there's only one match
--noinsert: Do not insert text until a selection is made
--noselect: Do not select, force user to select one from the menu
vim.opt.completeopt='menuone,noinsert,noselect'

vim.opt.cmdheight = 3

vim.cmd[[filetype plugin indent on]]

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- Permanent undo
vim.opt.undodir= os.getenv('HOME') .. "/.vimdid"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.showcmd = true
vim.opt.mouse = 'a'
