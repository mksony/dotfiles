local M = {}
--
-- M.lspconfig = {
--     v = {
--         ["<leader>ca"] = {
--             function() vim.lsp.buf.range_code_action() end,
--             "   lsp code_action"
--         }
--     }
-- }

M.telescope = {
    n = {
        ["<leader>fr"] = {
            function()
                require('telescope').extensions.frecency.frecency()
            end, "finde recent files"
        }
    }
}

M.lspconfig = {
    n = {
        ["<leader>ca"] = {"<cmd>Lspsaga code_action<CR>", "lsp code action"},
        ["gh"] = {"<cmd>Lspsaga lsp_finder<CR>", "lsp saga finder"}
    },
    v = {
        ["<leader>ca"] = {
            ":<C-U>Lspsaga range_code_action<CR>", "lsp range code action"
        }
    }
}

-- M.refactoring = {
--     v = {
--         ["<leader>rr"] = {
--             function() require('refactoring').select_refactor() end,
--             "lsp refactor"
--         }
--     }
-- }

return M;
