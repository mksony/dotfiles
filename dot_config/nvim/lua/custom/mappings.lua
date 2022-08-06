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
        ["<leader>ca"] = {
            function()
                vim.lsp.buf.code_action()
                -- local action = require("lspsaga.codeaction")
                -- action.code_action()
            end, "lsp code action"
        },
        ["gh"] = {
            function()
                local finder = require("lspsaga.finder").lsp_finder
                finder()
            end, "lsp saga finder"
        }
    },
    v = {
        ["<leader>ca"] = {
            function()
                vim.lsp.buf.range_code_action()
                -- local action = require("lspsaga.codeaction")
                -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true,
                --                                                false, true))
                -- action.range_code_action()
            end, "lsp range code action"
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
