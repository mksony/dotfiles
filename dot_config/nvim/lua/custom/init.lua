-- example file i.e lua/custom/init.lua
-- load your globals, autocmds here or anything .__.
-- require("core.utils").load_mappings()
local api = vim.api
vim.o.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.g.camelcasemotion_key = "<leader>"
-- -- Disable TAB completion for github copilot
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
vim.g.copilot_node_command = "~/.nvm/versions/node/v16.15.1/bin/node"

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp
})

api.nvim_create_autocmd("VimLeavePre", {command = "NvimTreeClose"})
