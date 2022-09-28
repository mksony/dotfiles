local M = {}

M.plugins = require "custom.plugins"

M.ui = {
    theme = "gruvchad",
    -- hl_add = require "custom.highlights",
    hl_override = {CursorLine = {bg = "black2"}},
    theme_toggle = {"gruvchad", "onedark"}
}

M.mappings = require "custom.mappings"

return M
