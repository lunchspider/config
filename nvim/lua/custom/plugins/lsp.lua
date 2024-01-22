return {
    {
        'neovim/nvim-lspconfig',
        config = function ()
            require "aman.lsp"
        end
    },
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {'j-hui/fidget.nvim', tag = 'legacy'},
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'windwp/nvim-autopairs',
    --  Snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
}
