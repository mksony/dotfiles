local saga = require 'lspsaga'

-- use default config
saga.init_lsp_saga()

local codeaction = require("lspsaga.codeaction")
local action = require("lspsaga.action")

saga.init_lsp_saga({
    -- Options with default value
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "single",
    -- when cursor in saga window you config these to move
    move_in_saga = {prev = '<C-p>', next = '<C-n>'},
    -- Error, Warn, Info, Hint
    -- use emoji like
    -- { "🙀", "😿", "😾", "😺" }
    -- or
    -- { "😡", "😥", "😤", "😐" }
    -- and diagnostic_header can be a function type
    -- must return a string and when diagnostic_header
    -- is function type it will have a param `entry`
    -- entry is a table type has these filed
    -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
    diagnostic_header = {" ", " ", " ", "ﴞ "},
    -- show diagnostic source
    show_diagnostic_source = true,
    -- add bracket or something with diagnostic source, just have 2 elements
    diagnostic_source_bracket = {},
    -- use emoji lightbulb in default
    code_action_icon = "💡",
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- same as nvim-lightbulb but async
    code_action_lightbulb = {enable = true, sign = true, sign_priority = 20, virtual_text = true},
    -- separator in finder
    finder_separator = "  ",
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>" -- quit can be a table
    },
    code_action_keys = {quit = "q", exec = "<CR>"},
    rename_action_quit = "<C-c>",
    definition_preview_icon = "  ",
    -- show symbols in winbar must nightly
    symbol_in_winbar = {in_custom = false, enable = false, separator = ' ', show_file = true, click_support = false}
})

-- lsp finder to find the cursor word definition and reference
vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, {silent = true, noremap = true})

-- code action
vim.keymap.set("n", "<leader>ca", codeaction.code_action, {silent = true, noremap = true})
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    codeaction.range_code_action()
end, {silent = true, noremap = true})

-- show hover doc
vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, {silent = true})

-- scroll down hover doc or scroll in definition preview
vim.keymap.set("n", "<C-f>", function()
    action.smart_scroll_with_saga(1)
end, {silent = true})
-- scroll up hover doc
vim.keymap.set("n", "<C-b>", function()
    action.smart_scroll_with_saga(-1)
end, {silent = true})

-- show signature help
vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, {silent = true, noremap = true})

-- rename
vim.keymap.set("n", "<leader>rn", require("lspsaga.rename").lsp_rename, {silent = true, noremap = true})
-- close rename win use <C-c> in insert mode or `q` in normal mode or `:q`

-- preview definition
vim.keymap.set("n", "gd", require("lspsaga.definition").preview_definition, {silent = true, noremap = true})

vim.keymap.set("n", "<leader>cd", require("lspsaga.diagnostic").show_line_diagnostics, {silent = true, noremap = true})

-- jump diagnostic
vim.keymap.set("n", "[e", require("lspsaga.diagnostic").goto_prev, {silent = true, noremap = true})
vim.keymap.set("n", "]e", require("lspsaga.diagnostic").goto_next, {silent = true, noremap = true})
-- or jump to error
vim.keymap.set("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({severity = vim.diagnostic.severity.ERROR})
end, {silent = true, noremap = true})
vim.keymap.set("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({severity = vim.diagnostic.severity.ERROR})
end, {silent = true, noremap = true})
