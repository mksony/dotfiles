local M = {}

local override = require "custom.override"

M.plugins = {
    override = {
        ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
        ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
        -- ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
        ["hrsh7th/nvim-cmp"] = override.cmp,
        -- ["wbthomason/packer.nvim"] = {snapshot = "stable_chad"},
        ["nvim-telescope/telescope.nvim"] = override.telescope,
        ["williamboman/mason.nvim"] = override.mason
        -- ["NvChad/ui"] = {
        -- statusline = {
        --     separator_style = "default", -- default/round/block/arrow
        --     overriden_modules = nil
        -- },

        -- lazyload it when there are 1+ buffers
        -- tabufline = {
        --     enabled = true,
        --     lazyload = false,
        --     overriden_modules = nil
        -- }
        -- }
    },
    user = require "custom.plugins"
}

M.ui = {
    theme = "gruvchad",
    -- hl_add = require "custom.highlights",
    theme_toggle = {"gruvchad", "onedark"}
}

M.mappings = require "custom.mappings"

return M
