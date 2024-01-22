return {
    { 'rose-pine/neovim', priority = 1000 },
    'christoomey/vim-tmux-navigator',
    'mbbill/undotree',
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    'airblade/vim-rooter',
    -- for translations
    'voldikss/vim-translator',
    'cespare/vim-toml',
    'stephpy/vim-yaml',
    'rhysd/vim-clang-format',
    'dag/vim-fish',
    'godlygeek/tabular',
    { 'prettier/vim-prettier', build = "yarn install --forzen-lockfile production" },
}
