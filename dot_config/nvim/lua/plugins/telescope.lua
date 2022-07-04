local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        color_devicons = true,
        sorting_strategy = "ascending",
        layout_config = {prompt_position = "top"},
        prompt_prefix = " 🔍 ",
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {i = {["<C-x>"] = false, ["<C-q>"] = actions.send_to_qflist}}
    },
    pickers = {find_files = {find_command = {"fd", "--type", "f", "--strip-cwd-prefix", "--hidden"}}},
    -- }
    -- extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
    extensions = {frecency = {default_workspace = 'CWD', show_scores = true, show_unindexed = true, disable_devicons = false}}
})

-- require("telescope").load_extension("fzy_native")
require"telescope".load_extension("frecency")
require("telescope").load_extension('fzf')
