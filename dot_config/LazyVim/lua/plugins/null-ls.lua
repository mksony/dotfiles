return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local null_ls_helpers = require("null-ls.helpers")
      local null_ls_utils = require("null-ls.utils")
      table.insert(opts.sources, nls.builtins.formatting.prettierd)
      table.insert(
        opts.sources,
        nls.builtins.formatting.eslint_d.with({
          cwd = null_ls_helpers.cache.by_bufnr(function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return null_ls_utils.root_pattern(".git")(params.bufname)
          end),
        })
      )
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local cspell = require("cspell")
      table.insert(opts.sources, cspell.diagnostics)
      table.insert(opts.sources, cspell.code_actions)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local null_ls_helpers = require("null-ls.helpers")
      local null_ls_utils = require("null-ls.utils")
      table.insert(
        opts.sources,
        nls.builtins.code_actions.eslint_d.with({
          cwd = null_ls_helpers.cache.by_bufnr(function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return null_ls_utils.root_pattern(".git")(params.bufname)
          end),
        })
      )

      table.insert(
        opts.sources,
        nls.builtins.diagnostics.eslint_d.with({
          cwd = null_ls_helpers.cache.by_bufnr(function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return null_ls_utils.root_pattern(".git")(params.bufname)
          end),
        })
      )
    end,
  },
}
