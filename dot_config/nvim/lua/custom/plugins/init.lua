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
    ["nvim-telescope/telescope-frecency.nvim"] = {
        requires = {"tami5/sqlite.lua", "nvim-telescope/telescope.nvim"}
    },
    ['nvim-telescope/telescope-fzf-native.nvim'] = {run = 'make'},
    ["tami5/sqlite.lua"] = {},
    ["hashivim/vim-terraform"] = {ft = "terraform"},
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
    },
    ['folke/trouble.nvim'] = {
        cmd = "TroubleToggle",
        config = function()
            require("custom.plugins.smolconfigs").trouble()
        end,
        requires = "kyazdani42/nvim-web-devicons"
    },
    ['f-person/git-blame.nvim'] = {cmd = "GitBlameToggle"},
    ['RRethy/vim-illuminate'] = {
        config = function()
            require("custom.plugins.smolconfigs").illuminate()
        end
    },
    ['yamatsum/nvim-cursorline'] = {
        config = function()
            require('nvim-cursorline').setup {
                cursorline = {enable = true, timeout = 0, number = false},
                cursorword = {
                    enable = false,
                    min_length = 3,
                    hl = {underline = true}
                }
            }
        end
    },
    ["kyazdani42/nvim-tree.lua"] = {
        override_options = {
            git = {enable = true, ignore = false},
            renderer = {highlight_git = true, icons = {show = {git = true}}},
            filters = {custom = {"\\.DS_Store$"}},
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {enable = true}

        }
    },
    ["nvim-treesitter/nvim-treesitter"] = {
        override_options = {
            ensure_installed = {
                "vim", "html", "css", "javascript", "json", "toml", "bash",
                "lua", "markdown", "markdown_inline", "typescript", "tsx",
                "yaml", "dockerfile", "hcl"
            },
            auto_install = true
        }
    },
    ["lukas-reineke/indent-blankline.nvim"] = {
        override_options = {show_current_context_start = false}
    },
    ["hrsh7th/nvim-cmp"] = {
        override_options = function()
            local cmp = require('cmp')
            return {
                sources = {
                    {name = "nvim_lsp"}, {name = "buffer"}, {name = "nvim_lua"},
                    {name = "path"}
                },
                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }),
                    ["<Tab>"] = cmp.config.disable,
                    ["<S-Tab>"] = cmp.config.disable
                }
            }

        end
    },
    -- ["wbthomason/packer.nvim"] = {snapshot = "stable_chad"},
    ["nvim-telescope/telescope.nvim"] = {
        module = "telescope",
        override_options = {
            pickers = {
                find_files = {
                    find_command = {
                        "fd", "--type", "f", "--strip-cwd-prefix", "--hidden",
                        "--no-ignore", "--exclude", ".git", "--exclude",
                        "*.DS_Store", "--exclude", "node_modules", "--exclude",
                        "dist"
                    }
                }
            },
            extensions_list = {"frecency", "fzf", "project"},
            extensions = {
                frecency = {
                    default_workspace = 'CWD',
                    ignore_patterns = {
                        "*.git/*", "*/tmp/*", "*/node_modules/*", "*/dist/*"
                    }
                },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                }
            }
        }
    },
    ["williamboman/mason.nvim"] = {
        override_options = {
            ensure_installed = {
                "lua-language-server", "stylua", "css-lsp", "html-lsp",
                "typescript-language-server", "json-lsp", "shfmt", "shellcheck"
            }
        }
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
