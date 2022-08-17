local M = {}

M.treesitter = {
    ensure_installed = {
        "vim", "html", "css", "javascript", "json", "toml", "bash", "lua",
        "markdown", "markdown_inline", "typescript", "tsx", "yaml",
        "dockerfile", "hcl"
    },
    auto_install = true
}
--
M.nvimtree = {
    git = {enable = true, ignore = false},
    renderer = {highlight_git = true, icons = {show = {git = true}}},
    filters = {custom = {"\\.DS_Store$"}},
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {enable = true}
}
--
M.blankline = {
    filetype_exclude = {
        "help", "terminal", "alpha", "packer", "lspinfo", "TelescopePrompt",
        "TelescopeResults", "nvchad_cheatsheet", "lsp-installer", "norg", ""
    }
}

M.cmp = function()
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
M.telescope = {
    pickers = {
        find_files = {
            find_command = {
                "fd", "--type", "f", "--strip-cwd-prefix", "--hidden",
                "--no-ignore", "--exclude", ".git", "--exclude", "*.DS_Store",
                "--exclude", "node_modules", "--exclude", "dist"
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

M.mason = {
    ensure_installed = {
        "lua-language-server", "stylua", "css-lsp", "html-lsp",
        "typescript-language-server", "json-lsp", "shfmt", "shellcheck"
    }
}

return M
