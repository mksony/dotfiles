---@type MappingsTable
local M = {}

M.general = {}

M.telescope = {
  n = {
    ["<leader>fr"] = {
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      "finde recent files",
    },
    ["<leader>fp"] = { "<cmd>Telescope project<CR>", "find recent projects" },
  },
}

M.lspconfig = {
  n = {
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "lsp code action" },
    ["gh"] = { "<cmd>Lspsaga lsp_finder<CR>", "lsp saga finder" },
  },
  v = {
    ["<leader>ca"] = {
      "<cmd>Lspsaga code_action<CR><ESC>",
      "lsp code action",
    },
  },
}

M.trouble = {
  n = {
    ["<leader>xx"] = { "<cmd>TroubleToggle<CR>", "trouble" },
    ["<leader>xw"] = {
      "<cmd>TroubleToggle workspace_diagnostics<CR>",
      "trouble workspace diagnostics",
    },
  },
}

M.git_blame = { n = { ["<leader>bi"] = { "<cmd>GitBlameToggle<CR>", "git blame" } } }

M.lsp_lines = {
  n = {
    ["<leader>ll"] = {
      function()
        require("lsp_lines").toggle()
      end,
      "toggle lsp lines",
    },
  },
}

-- M.cybu = {
--   n = {
--     ["<c-s-tab>"] = {
--       "<plug>(CybuLastusedPrev)",
--       "previous buffer",
--     },
--     ["<c-tab>"] = {
--       "<plug>(CybuLastusedNext)",
--       "next buffer",
--     },
--   },
--   v = {
--     ["<c-s-tab>"] = {
--       "<plug>(CybuLastusedPrev)",
--       "previous buffer",
--     },
--     ["<c-tab>"] = {
--       "<plug>(CybuLastusedNext)",
--       "next buffer",
--     },
--   },
-- }

-- M.refactoring = {
--     v = {
--         ["<leader>rr"] = {
--             function() require('refactoring').select_refactor() end,
--             "lsp refactor"
--         }
--     }
-- }

M.spectre = {
  n = {
    ["<leader>S"] = {
      function()
        require("spectre").open()
      end,
      "spectre",
    },
    ["<leader>sw"] = {
      function()
        require("spectre").open_visual {
          select_word = true,
        }
      end,
      "spectre word",
    },
  },
  v = {
    ["<leader>sw"] = {
      function()
        require("spectre").open_visual()
      end,
      "spectre",
    },
    ["<leader>sp"] = {
      function()
        require("spectre").open_visual {
          select_word = true,
        }
      end,
      "spectre word",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["gcc"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["gcc"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

return M
