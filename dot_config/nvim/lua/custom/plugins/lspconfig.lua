local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({virtual_text = false})

local typescript = require "typescript"
typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
        root_dir = vim.loop.cwd,
        init_options = {
            tsserver = {
                preferences = {importModuleSpecifierPreference = 'relative'}
            }
        }
    }
})

local lspconfig = require "lspconfig"

lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = {enable = true}
        }
    }
}

local servers = {"html", "cssls", "bashls", "terraformls", "dockerls"}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities),
        root_dir = vim.loop.cwd
    }
end
