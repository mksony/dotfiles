local M = {}

M.autotag = function()
    local present, autotag = pcall(require, "nvim-ts-autotag")

    if present then autotag.setup() end
end

M.shade = function()
    local present, shade = pcall(require, "shade")

    if not present then return end

    shade.setup {
        overlay_opacity = 50,
        opacity_step = 1,
        exclude_filetypes = {"NvimTree"}
    }
end

M.surround = function()
    local present, surround = pcall(require, "nvim-surround")

    if present then surround.setup() end
end

M.dressing = function()
    local present, dressing = pcall(require, "dressing.nvim")

    if present then
        dressing.setup({input = {enable = false}, select = {enable = true}})
    end
end

-- M.refactoring = function()
--     local present, refactoring = pcall(require, "refactoring")
--
--     if present then refactoring.setup() end
-- end

M.auto_session = function()
    local present, auto_session = pcall(require, "auto-session")

    if present then
        auto_session.setup({
            log_level = 'error',
            -- auto_session_enable_last_session = false,
            -- auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
            -- auto_session_enabled = true,
            -- auto_save_enabled = nil,
            -- auto_restore_enabled = nil,
            -- auto_session_suppress_dirs = nil,
            auto_session_use_git_branch = true
            -- bypass_session_save_file_types = nil, -- boolean: Bypass auto save when only buffer open is one of these file types
            -- cwd_change_handling = { -- table: Config for handling the DirChangePre and DirChanged autocmds, can be set to nil to disable altogether
            --     restore_upcoming_session = true -- boolean: restore session for upcoming cwd on cwd change
            -- pre_cwd_changed_hook = function()
            --     require('core.utils').closeAllBufs()
            -- end -- function: This is called after auto_session code runs for the `DirChangedPre` autocmd
            -- post_cwd_changed_hook = nil -- function: This is called after auto_session code runs for the `DirChanged` autocmd
            -- bypass_session_save_file_types = nil
            -- }
        })
    end
end

return M
