return {
    ["jose-elias-alvarez/typescript.nvim"] = {},
    ["neovim/nvim-lspconfig"] = {
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.plugins.lspconfig"
        end
    },
    -- autoclose tags in html, jsx etc
    ["windwp/nvim-ts-autotag"] = {
        ft = {"html", "javascriptreact"},
        after = "nvim-treesitter",
        config = function()
            require("custom.plugins.smolconfigs").autotag()
        end
    },

    -- format & linting
    ["jose-elias-alvarez/null-ls.nvim"] = {
        config = function() require "custom.plugins.null-ls" end,
        after = {"nvim-lspconfig"},
        requires = {"nvim-lua/plenary.nvim"}
    },

    -- ["jose-elias-alvarez/typescript.nvim"] = {after = "nvim-lspconfig"},
    ["bkad/CamelCaseMotion"] = {},
    ["github/copilot.vim"] = {},
    ['vimwiki/vimwiki'] = {after = "nvim-treesitter"},
    -- ["wellle/targets.vim"] = {},
    ["kylechui/nvim-surround"] = {
        config = function()
            require("custom.plugins.smolconfigs").surround()
        end
    },
    ["nvim-telescope/telescope.nvim"] = {module = "telescope"},
    ["nvim-telescope/telescope-frecency.nvim"] = {
        requires = {"tami5/sqlite.lua", "nvim-telescope/telescope.nvim"}
    },
    ['nvim-telescope/telescope-fzf-native.nvim'] = {run = 'make'},
    ["tami5/sqlite.lua"] = {},
    ["hashivim/vim-terraform"] = {},
    ['editorconfig/editorconfig-vim'] = {},
    ['glepnir/lspsaga.nvim'] = {
        branch = "main",
        config = function()
            local saga = require("lspsaga")

            saga.init_lsp_saga({
                code_action_lightbulb = {enable = false, virtual_text = false}
            })
        end
    },
    ["stevearc/dressing.nvim"] = {
        config = function()
            require("custom.plugins.smolconfigs").dressing()
        end

    },
    -- -- minimal modes
    -- ["Pocco81/TrueZen.nvim"] = {
    --    cmd = {
    --       "TZAtaraxis",
    --       "TZMinimalist",
    --       "TZFocus",
    --    },
    --    config = function()
    --       require "custom.plugins.truezen"
    --    end,
    -- },

    -- notes stuff
    -- ["nvim-neorg/neorg"] = {
    --     ft = "norg",
    --     after = "nvim-treesitter",
    --     config = function() require "custom.plugins.neorg" end
    -- },

    -- get highlight group under cursor
    ["nvim-treesitter/playground"] = {
        cmd = "TSCaptureUnderCursor",
        config = function() require("nvim-treesitter.configs").setup() end
    },
    -- dim inactive windows
    ["andreadev-it/shade.nvim"] = {
        module = "shade",
        config = function() require("custom.plugins.smolconfigs").shade() end
    },
    ["goolord/alpha-nvim"] = {disable = false},
    -- ["Pocco81/AutoSave.nvim"] = {
    --    module = "autosave",
    --    config = function()
    --       require("custom.plugins.smolconfigs").autosave()
    --    end,
    -- },
    ['rmagatti/auto-session'] = {
        config = function()
            require("custom.plugins.smolconfigs").auto_session()
        end
    },
    ["b0o/schemastore.nvim"] = {},
    -- ['nvim-orgmode/orgmode'] = {
    --     config = function()
    --         local orgmode = require("orgmode")
    --         orgmode.setup_ts_grammar()
    --         orgmode.setup({
    --             org_agenda_files = {'~/notes/work/**/*'},
    --             org_default_notes_file = '~/notes/work/quick-notes.org'
    --         })
    --     end
    -- },
    -- ["ThePrimeagen/refactoring.nvim"] = {
    --     requires = {
    --         {"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}
    --     },
    --     config = function()
    --         require("custom.plugins.smolconfigs").refactoring()
    --     end
    -- }
    ["folke/which-key.nvim"] = {disable = false},
    ['nvim-telescope/telescope-project.nvim'] = {},
    ['j-hui/fidget.nvim'] = {
        module = "fidget",
        config = function()
            require("custom.plugins.smolconfigs").fidget()
        end

    },
    ['echasnovski/mini.nvim'] = {
        config = function() require("custom.plugins.smolconfigs").mini() end
    },
    ['glacambre/firenvim'] = {
        run = function() vim.fn['firenvim#install'](0) end
    },
    ['Maan2003/lsp_lines.nvim'] = {
        config = function()
            require("custom.plugins.smolconfigs").lsp_lines()
        end
    }
    -- ["ahmedkhalf/project.nvim"] = {
    --     config = function()
    --         require("project_nvim").setup {
    --             detection_methods = {"pattern"},
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --             patterns = {".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile"}
    --         }
    --     end,
    --     requires = {"nvim-telescope/telescope.nvim"}
    -- }
}
