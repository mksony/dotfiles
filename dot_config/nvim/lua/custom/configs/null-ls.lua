local present, null_ls = pcall(require, "null-ls")
local null_ls_utils = require "null-ls.utils"
local null_ls_helpers = require "null-ls.helpers"
local cspell = require "cspell"
require("lsp-format").setup {}

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd.with {
    cwd = null_ls_helpers.cache.by_bufnr(function(params)
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
      return null_ls_utils.root_pattern ".git"(params.bufname)
    end),
  },
  b.formatting.eslint_d.with {
    cwd = null_ls_helpers.cache.by_bufnr(function(params)
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
      return null_ls_utils.root_pattern ".git"(params.bufname)
    end),
  }, -- Lua
  b.diagnostics.actionlint,
  cspell.diagnostics,
  cspell.code_actions,
  -- b.diagnostics.editorconfig_checker, -- b.formatting.stylua, -- Shell
  b.formatting.stylua.with {
    cwd = null_ls_helpers.cache.by_bufnr(function(params)
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
      return null_ls_utils.root_pattern ".git"(params.bufname)
    end),
  },
  b.formatting.terraform_fmt,
  b.code_actions.eslint_d.with {
    cwd = null_ls_helpers.cache.by_bufnr(function(params)
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
      return null_ls_utils.root_pattern ".git"(params.bufname)
    end),
  },
  b.diagnostics.eslint_d.with {
    cwd = null_ls_helpers.cache.by_bufnr(function(params)
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
      return null_ls_utils.root_pattern ".git"(params.bufname)
    end),
  },
  require "typescript.extensions.null-ls.code-actions",
}

null_ls.setup {
  debug = false,
  sources = sources,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
    require("lsp-format").on_attach(client)
    -- if client.supports_method "textDocument/formatting" then
    --   vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     group = augroup,
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.buf.format {
    --         bufnr = bufnr,
    --         filter = function(client)
    --           return client.name == "null-ls"
    --         end,
    --       }
    --     end,
    --   })
    -- end
  end,
}
