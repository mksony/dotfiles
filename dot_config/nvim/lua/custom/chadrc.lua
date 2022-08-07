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
    },
    user = require "custom.plugins"
}

M.ui = {
    theme = "gruvchad"
    -- hl_add = require "custom.highlights",
    -- theme_toggle = { "gruvchad", "gruvbox_light" },
}

M.mappings = require "custom.mappings"

return M
