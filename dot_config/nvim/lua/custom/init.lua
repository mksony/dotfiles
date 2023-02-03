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

api.nvim_create_autocmd("Filetype", {
    pattern = "vimwiki",
    command = "silent! iunmap <buffer> <Tab>"
})

-- api.nvim_create_autocmd("VimLeavePre", {
--     callback = function()
--         -- Clear all buffers and jumps after session save so session doesn't blead over to next session.
--         if (vim.exists('g:started_by_firenvim')) then return end
--         vim.cmd "NvimTreeClose"
--     end
-- })

vim.api.nvim_create_autocmd("DirChangedPre", {
    callback = function()
        auto_session.AutoSaveSession()

        -- Clear all buffers and jumps after session save so session doesn't blead over to next session.
        vim.cmd "clearjumps"
        vim.cmd "silent! %bwipeout!"

    end,
    pattern = "global"
})

-- local cursorLineGrp = api.nvim_create_augroup("CursorLine", {clear = true})
-- api.nvim_create_autocmd({"BufEnter", "VimEnter", "WinEnter", "BufWinEnter"}, {
--     pattern = "*",
--     command = "setlocal cursorline",
--     group = cursorLineGrp
-- })
--
-- api.nvim_create_autocmd("WinLeave", {
--     pattern = "*",
--     command = "setlocal nocursorline",
--     group = cursorLineGrp
-- })
--
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

vim.cmd 'let g:firenvim_config = { "globalSettings": { "alt": "all", }, "localSettings": { ".*": { "cmdline": "neovim", "content": "text", "priority": 0, "selector": "textarea", "takeover": "always", }, } }'

-- Disable `firenvim` for the particular webiste
vim.cmd 'let fc = g:firenvim_config["localSettings"]'
vim.cmd 'let fc["https?://twitter.com/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://twitter.tv/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://mail.google.com/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://jira.media-saturn.com/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://confluence.media-saturn.com/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://reetro.app/"] = { "takeover": "never", "priority": 1 }'
vim.cmd 'let fc["https?://console.cloud.google.com/"] = { "takeover": "never", "priority": 1 }'

-- Change `firenvim` file type to enable syntax highlight, `coc` works perfectly
-- " after this settings!!!
vim.cmd 'autocmd BufEnter github.com_*.txt set filetype=markdown'
vim.cmd 'autocmd BufEnter txti.es_*.txt set filetype=typescript'

-- Increase the font size to solve the `text too small` issue
function IsFirenvimActive(event)
    if vim.g.enable_vim_debug then
        print("IsFirenvimActive, event: ", vim.inspect(event))
    end

    if vim.fn.exists('*nvim_get_chan_info') == 0 then return 0 end

    local ui = vim.api.nvim_get_chan_info(event.chan)
    if vim.g.enable_vim_debug then
        print("IsFirenvimActive, ui: ", vim.inspect(ui))
    end

    --[[
    If this function is running in browser, the `ui` looks like below:
    {
        client = {
            attributes = {
                [true] = 6 -- The channel number
            },
            methods = {
                [true] = 6 -- The channel number
            },
            name = "Firenvim",
            type = "ui",
            version = {
                -- ignore more info here
            }
        },
        id = 5, -- 
        mode = "rpc",
        stream = "socket
    }

    Otherwise, it looks like this:
    {
        [true] = 6 -- The channel name
    }
    --]]
    local is_firenvim_active_in_browser =
        (ui['client'] ~= nil and ui['client']['name'] ~= nil)
    if vim.g.enable_vim_debug then
        print("is_firenvim_active_in_browser: ", is_firenvim_active_in_browser)
    end
    return is_firenvim_active_in_browser
end

function OnUIEnter(event)
    if IsFirenvimActive(event) then
        -- Disable the status bar
        vim.cmd 'set laststatus=0'
        vim.cmd 'set guifont=FiraCode\\ Nerd\\ Font\\ Mono'
    end
end

local firenvim_font_group =
    api.nvim_create_augroup("fnvim_font", {clear = true})
api.nvim_create_autocmd("UIEnter", {
    callback = function() OnUIEnter(vim.fn.deepcopy(vim.v.event)) end,
    pattern = "*"
})
