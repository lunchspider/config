-- fish doesn't always work
vim.g["shell"] = "/bin/bash"
-- =============================================================================
-- # installing packages
-- =============================================================================
-- Load packer
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

require('packer').startup(function(use)
    -- Load useins
    --VIM enhancements
    use 'wbthomason/packer.nvim'
    use 'ciaranm/securemodelines'
    use 'editorconfig/editorconfig-vim'
    use 'justinmk/vim-sneak'
    use 'morhetz/gruvbox'
    use 'christoomey/vim-tmux-navigator'
    use 'mbbill/undotree'

    -- Git integration
    use 'tpope/vim-fugitive'

    -- File tree useins
    use 'nvim-tree/nvim-web-devicons' -- optional, for file icons
    use 'nvim-tree/nvim-tree.lua'

    -- GUI enhancements
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'andymass/vim-matchup'

    -- Fuzzy finder
    use 'airblade/vim-rooter'
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use 'junegunn/fzf.vim'

    -- Semantic language support
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }

    -- Autocompletion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'windwp/nvim-autopairs'

    --  Snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'

    use 'VonHeikemen/lsp-zero.nvim'

    -- Syntactic language support
    use 'cespare/vim-toml'
    use 'stephpy/vim-yaml'
    use 'rust-lang/rust.vim'
    use 'rhysd/vim-clang-format'
    --use 'fatih/vim-go'
    use 'dag/vim-fish'
    use 'godlygeek/tabular'
    use 'plasticboy/vim-markdown'
end)
if packer_bootstrap then
    require('packer').sync()
end
require("mason").setup()
require('nvim-tree').setup()
require("nvim-autopairs").setup {}


local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
})

local cmp_mapping = lsp.defaults.cmp_mapping
-- getting the ghost text on screen!
lsp.setup_nvim_cmp({
    mapping = cmp_mapping,
    experimental = {
        ghost_text = true,
    },
})

-- Setup lspconfig.
lsp.on_attach(function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end)

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

-- becauing doing vim.cmd again and again is boring
local vimrc = vim.fn.stdpath("config") .. "/setup.vim"
vim.cmd.source(vimrc)
