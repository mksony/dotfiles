return {
  { "jose-elias-alvarez/typescript.nvim" },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
        dependencies = {
          "davidmh/cspell.nvim",
        },
      },
      {
        "Maan2003/lsp_lines.nvim",
        config = function()
          require("custom.configs.smolconfigs").lsp_lines()
        end,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascriptreact" },
    after = "nvim-treesitter",
    config = function()
      require("custom.configs.smolconfigs").autotag()
    end,
  },
  { "bkad/CamelCaseMotion", event = "VeryLazy" },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      require("copilot").setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node",
        server_opts_overrides = {},
      }
    end,
  },
  { "vimwiki/vimwiki", after = "nvim-treesitter", event = "VeryLazy" },
  {
    "kylechui/nvim-surround",
    config = function()
      require("custom.configs.smolconfigs").surround()
    end,
    event = "VeryLazy",
  },
  -- add config for coqvim
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "tami5/sqlite.lua" },
  { "hashivim/vim-terraform", ft = "terraform" },
  { "editorconfig/editorconfig-vim", event = "VeryLazy" },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
      local saga = require "lspsaga"

      saga.setup {}
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.smolconfigs").dressing()
    end,
  },

  -- dim inactive windows
  {
    "andreadev-it/shade.nvim",
    module = "shade",
    config = function()
      require("custom.configs.smolconfigs").shade()
    end,
  },
  -- {
  --   "rmagatti/auto-session",
  --   config = function()
  --     require("custom.configs.smolconfigs").auto_session()
  --   end,
  --   lazy = false,
  -- },
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup {
        use_git_branch = true,
        autoload = true,
        should_autosave = function()
          -- do not autosave if the alpha dashboard is the current filetype
          if vim.g.started_by_firenvim == nil or vim.g.started_by_firenvim == false then
            return true
          end
          return false
        end,
        ignored_dirs = { ".git", "node_modules", ".cache", "/private" },
      }
    end,
    lazy = false,
  },
  { "b0o/schemastore.nvim", ft = "json" },
  { "nvim-telescope/telescope-project.nvim" },
  {
    "j-hui/fidget.nvim",
    module = "fidget",
    event = "VeryLazy",
    config = function()
      require("custom.configs.smolconfigs").fidget()
    end,
  },
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.smolconfigs").mini()
    end,
  },
  {
    "glacambre/firenvim",

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = false,
    cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load { plugins = "firenvim", wait = true }
      vim.fn["firenvim#install"](0)
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("custom.configs.smolconfigs").trouble()
    end,
    requires = "kyazdani42/nvim-web-devicons",
  },
  { "f-person/git-blame.nvim", cmd = "GitBlameToggle" },
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup {
        cursorline = { enable = true, timeout = 1000, number = false },
        cursorword = {
          enable = false,
          min_length = 3,
          hl = { underline = true },
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose" },
    opts = {
      git = { enable = true, ignore = false },
      renderer = { highlight_git = true, icons = { show = { git = true } } },
      filters = { custom = { "\\.DS_Store$" } },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = { enable = true },
      view = {
        adaptive_size = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "html",
        "css",
        "javascript",
        "json",
        "toml",
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "typescript",
        "tsx",
        "yaml",
        "dockerfile",
        "hcl",
      },
      auto_install = true,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = { show_current_context_start = false },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require "cmp"
      return {
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ["<Tab>"] = cmp.config.disable,
          ["<S-Tab>"] = cmp.config.disable,
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    opts = {
      pickers = {
        find_files = {
          find_command = {
            "fd",
            "--type",
            "f",
            "--strip-cwd-prefix",
            "--hidden",
            "--no-ignore",
            "--exclude",
            ".git",
            "--exclude",
            "*.DS_Store",
            "--exclude",
            "node_modules",
            "--exclude",
            "dist",
          },
        },
      },
      extensions_list = { "fzf", "project" },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "eslint_d",
        "cspell",
        "lua-language-server",
        "stylua",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",
        "shfmt",
        "shellcheck",
      },
    },
  },
  {
    "lukas-reineke/lsp-format.nvim",
    event = "VeryLazy",
  },
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    config = function()
      require("oil").setup()
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "johmsalas/text-case.nvim",
    event = "VeryLazy",
    config = function()
      require("textcase").setup()
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    module = "spectre",
    config = function()
      require("spectre").setup()
    end,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true, event = "VeryLazy" },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
}
