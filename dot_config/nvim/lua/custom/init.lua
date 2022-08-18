-- example file i.e lua/custom/init.lua
-- load your globals, autocmds here or anything .__.
-- require("core.utils").load_mappings()
local api = vim.api
local opt = vim.opt
local util = require("core.utils")
local auto_session = require("auto-session")

opt.relativenumber = true
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

vim.g.vimwiki_map_prefix = '<leader><leader>w'
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {{path = '~/vimwiki/', syntax = 'markdown', ext = '.md'}}
api.nvim_create_autocmd("BufNewFile", {
    pattern = "*/vimwiki/diary/*.md",
    command = ":silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'"
})

api.nvim_create_autocmd("Filetype", {
    pattern = "vimwiki",
    command = "silent! iunmap <buffer> <Tab>"
})

api.nvim_create_autocmd("VimLeavePre", {command = "NvimTreeClose"})

vim.api.nvim_create_autocmd("DirChangedPre", {
    callback = function()
        auto_session.AutoSaveSession()

        -- Clear all buffers and jumps after session save so session doesn't blead over to next session.
        vim.cmd "clearjumps"
        vim.cmd "silent! %bwipeout!"

    end,
    pattern = "global"
})

vim.api.nvim_create_autocmd("DirChanged", {
    callback = function()
        -- Deferring to avoid otherwise there are tresitter highlighting issues
        local telescope = require("telescope.actions")
        vim.defer_fn(function()
            local is_telescope = false
            if vim.api.nvim_win_get_config(api.nvim_get_current_win()).zindex then
                is_telescope = true
                telescope.close(api.nvim_get_current_buf())
            end
            auto_session.AutoRestoreSession()
            if is_telescope then vim.cmd "Telescope find_files" end
        end, 100)
    end,
    pattern = "global"
})
