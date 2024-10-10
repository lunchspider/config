require("mason").setup()
require("nvim-autopairs").setup {}
require("fidget").setup {}

-- Setup lspconfig.
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
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
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { 'clangd', 'rust_analyzer', 'pyright',
    'tailwindcss', 'jdtls', 'ts_ls', 'cssls', 'lua_ls', 'arduino_language_server', 'texlab'  }


function CheckVueInstall()
    local packageJson = string.format("%s/package.json", vim.loop.cwd())
    local f = io.open(packageJson, "rb")
    if not f then return false end
    local content = f:read("*a")
    local doesExist = false
    local x = string.find(content, "vue")
    if x then
        doesExist = true
    end
    f:close()
    return doesExist
end

if CheckVueInstall() then
    local index = 1;
    for k, v in ipairs(servers) do
        if v == "tsserver" then
            index = k
        end
    end
    table.remove(servers, index);
    local util = require 'lspconfig.util'

    local function get_typescript_server_path(root_dir)
        --local global_ts = '/home/aman/.npm/lib/node_modules/typescript/lib'
        -- Alternative location if installed as root:
        local global_ts = '/usr/local/lib/node_modules/typescript/lib'
        local found_ts = ''
        local function check_dir(path)
            found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
            if util.path.exists(found_ts) then
                return path
            end
        end
        if util.search_ancestors(root_dir, check_dir) then
            return found_ts
        else
            return global_ts
        end
    end

    require 'lspconfig'.volar.setup {
        filetypes = { 'typescript', 'javascript', 'vue' },
        on_new_config = function(new_config, new_root_dir)
            new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
        end,
    }
end

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
    ensure_installed = servers,
}

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_flags = { debounce_text_changes = 50 };


for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags
    }
end


require('lspconfig').rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
})

require'lspconfig'.texlab.setup {
    capabilities=capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = { "texlab" },
    filetypes = { "tex", "bib" },
    root_dir = function(filename)
          return require'lspconfig.util'.path.dirname(filename)
        end,
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = true,
        }
      }
    }
}

require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

require('lspconfig').arduino_language_server.setup({
    cmd = {
       require('mason-core.path').bin_prefix('arduino-language-server'),
       "-cli-config", "/home/aman/.arduino15/arduino-cli.yaml",
       "-fqbn", "arduino:avr:uno",
       "-cli", os.getenv('HOME') .. '/.local/bin/arduino-cli',
       "-clangd", require('mason-core.path').bin_prefix('clangd')
    }
})

local lsp = require('lspconfig');

lsp.ocamllsp.setup{
   cmd = { "ocamllsp" },
   filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
   root_dir = lsp.util.root_pattern("*.opam", "esy.json", "package.json", "dune-project", "dune-workspace"),
   on_attach = on_attach,
   capabilities = capabilities
}


local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
        { name = "cmdline" }
    })
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
    }
)

vim.diagnostic.config({
    virtual_text = true
})

