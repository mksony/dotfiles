local present, null_ls = pcall(require, "null-ls")

if not present then return end

local b = null_ls.builtins

local sources = {

    -- webdev stuff
    b.formatting.prettierd.with({
        cwd = function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return
                require'null-ls.utils'.root_pattern( -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
                ".git")(params.bufname)
        end
    }), b.formatting.eslint_d.with({
        cwd = function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return
                require'null-ls.utils'.root_pattern( -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
                ".git")(params.bufname)
        end
    }), -- Lua
    b.diagnostics.actionlint, --[[ b.diagnostics.cspell, ]]
    -- b.diagnostics.editorconfig_checker, -- b.formatting.stylua, -- Shell
    b.formatting.terraform_fmt, b.formatting.lua_format,
    b.code_actions.eslint_d, b.diagnostics.eslint_d.with({
        cwd = function(params)
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/pull/833
            return
                require'null-ls.utils'.root_pattern( -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
                ".git")(params.bufname)
        end
    })
}

null_ls.setup {
    debug = true,
    sources = sources,
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end
            })
        end
    end
}
