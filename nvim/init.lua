-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
require("luasnip.loaders.from_vscode").lazy_load()

vim.cmd.colorscheme("no-clown-fiesta")
-- =========================================
-- 🔍 TELESCOPE
-- =========================================
local telescope = require("telescope")
telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        path_display = { "smart" },
        file_ignore_patterns = {
            "node_modules",
            ".git",
            "target",
            "build",
            "dist",
            "__pycache__",
        },
    },
})

-- =========================================
-- 🧭 BUFFERLINE
-- =========================================
require("bufferline").setup({
    options = {
        separator_style = "slanted",
        always_show_bufferline = false,
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        offsets = {
            { filetype = "NvimTree", text = "Explorer", highlight = "Directory", text_align = "center" },
        },
        hover = { enabled = true, delay = 200, reveal = { "close" } },
        persist_buffer_sort = true,
        sort_by = "id",
    },
    highlights = {
        buffer_selected = { italic = true, bold = true },
        fill = { bg = "#1e1e2e" },
        background = { fg = "#a9b1d6", bg = "#1e1e2e" },
    },
})

require("oil").setup({
    default_file_explorer = true,

    columns = {
        "icon",
    },

    keymaps = {
        ["h"] = "actions.parent",
        ["l"] = "actions.select",

        -- tu gardes le reste si tu veux :
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" } },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
    },
    view_options = {
        show_hidden = false,
        natural_order = "fast",
        sort = {
            { "type", "asc" },
            { "name", "asc" },
        },
    },

    preview_win = {
        update_on_cursor_moved = true,
        preview_method = "fast_scratch",
    },
})

-- Après require("neo-tree").setup({...})
vim.api.nvim_set_hl(0, "NeoTreeFileNameCurrent", { fg = "#ff9e64", bg = "#2a2a2a", bold = true })
