local nvim_lsp = require 'lspconfig'
local saga = require('lspsaga')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

local attach_auto_save = function(client)
    vim.api.nvim_exec([[
        augroup formatting
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting(nil, 200)
        augroup END
        ]], true)
end

require("trouble").setup {}

local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        -- null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
        null_ls.builtins.code_actions.eslint_d -- eslint or eslint_d
        -- null_ls.builtins.formatting.prettier -- prettier, eslint, eslint_d, or prettierd
    }
})

-- require("lspconfig")["null-ls"].setup {
--     on_attach = function(client, bufnr)
--         -- disable tsserver formatting if you plan on formatting via null-ls
--         client.resolved_capabilities.document_formatting = false
--         client.resolved_capabilities.document_range_formatting = false
--     end
-- }
require("lsp-colors").setup({Error = "#db4b4b", Warning = "#e0af68", Information = "#0db9d7", Hint = "#10B981"})
require"lsp_signature".setup()
local cmp = require "cmp"
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
        ['<C-e>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = {{name = "nvim_lsp"}, {name = "buffer"}, {name = 'vsnip'}},
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind -- set a name for each source
            vim_item.menu =
                ({buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]", latex_symbols = "[Latex]"})[entry.source.name]
            return vim_item
        end
    }
}
-- Use buffer source for `/`.
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})})

nvim_lsp.tsserver.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- attach_auto_save(client)
        -- disable tsserver formatting if you plan on formatting via null-ls
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            import_all_priorities = {
                buffers = 4, -- loaded buffer names
                buffer_content = 3, -- loaded buffer content
                local_files = 2, -- git files or files with relative path markers
                same_file = 1 -- add to existing import statement
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_enable_disable_comments = true,
            eslint_bin = "eslint_d",
            eslint_config_fallback = nil,
            eslint_enable_diagnostics = false,
            eslint_show_rule_id = false,

            -- formatting
            enable_formatting = false,
            formatter = "prettier_d_slim",
            formatter_config_fallback = nil,

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {}
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = {silent = true}
        vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", opts)
    end
}

local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
}

local prettier = {formatCommand = "prettier_d_slim --stdin --stdin-filepath ${INPUT}", formatStdin = true}

local function eslint_config_exists()
    local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

    if not vim.tbl_isempty(eslintrc) then return true end

    if vim.fn.filereadable("package.json") then if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then return true end end

    return false
end

-- local format_async = function(err, _, result, _, bufnr)
--     if err ~= nil or result == nil then return end
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then vim.api.nvim_command("noautocmd :update") end
--     end
-- end

-- vim.lsp.handlers["textDocument/formatting"] = format_async

local luafmt = {
    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
    formatStdin = true
}

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/Users/karacsonym/repos/bin/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- attach_auto_save(client)
    end,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

nvim_lsp.efm.setup {
    root_dir = require("lspconfig").util.root_pattern {".git/", "."},
    init_options = {documentFormatting = true, codeAction = false},
    on_attach = on_attach,
    -- root_dir = function()
    --   if not eslint_config_exists() then
    --     return nil
    --   end
    --   return vim.fn.getcwd()
    -- end,
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {luafmt},
            yaml = {prettier},
            markdown = {prettier},
            -- json = {prettier},
            javascript = {prettier, eslint},
            javascriptreact = {eslint, prettier},
            ["javascript.jsx"] = {eslint, prettier},
            typescript = {eslint, prettier},
            ["typescript.tsx"] = {eslint, prettier},
            typescriptreact = {eslint, prettier},
            css = {prettier},
            scss = {prettier},
            sass = {prettier},
            less = {prettier},
            graphql = {prettier},
            vue = {prettier},
            html = {prettier}
        }
    },
    filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescript.tsx", "typescriptreact", "lua"}
}

-- vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
saga.init_lsp_saga()

local renamer = require("renamer")

renamer.setup()

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {show_parameter_hints = false, parameter_hints_prefix = "", other_hints_prefix = ""}
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {command = "clippy"}
            }
        }
    }
}

require('rust-tools').setup(opts)

local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {"yamlls", "bashls", "terraformls", "dockerls", "jsonls", "sqls", "tflint"}

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function()
            -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
            -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.
            local opts = {}
            server:setup(opts)
        end)
        if not server:is_installed() then
            -- Queue the server to be installed.
            server:install()
        end
    end
end

-- local autosave = require("autosave")

-- autosave.setup({
--     enabled = true,
--     execution_message = function()
--         return "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
--     end,
--     events = {"InsertLeave"},
--     conditions = {exists = true, filename_is_not = {}, filetype_is_not = {}, modifiable = true},
--     write_all_buffers = false,
--     on_off_commands = true,
--     clean_command_line_interval = 0,
--     debounce_delay = 150
-- })
