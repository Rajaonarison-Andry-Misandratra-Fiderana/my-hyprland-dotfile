-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.cmd([[colorscheme no-clown-fiesta]])
require("luasnip.loaders.from_vscode").lazy_load()

-- =============================================
-- 🛜 LUALINE - THÈME NORDIC
-- =============================================
local status, lualine = pcall(require, "lualine")
if not status then
    return
end

-- Palette de couleurs nordic
local colors = {
    bg = "#2E3440",
    fg = "#D8DEE9",
    snow = "#ECEFF4",
    frost = "#8FBCBB",
    aurora = "#BF616A",
    gold = "#EBCB8B",
    pine = "#A3BE8C",
    polar = "#81A1C1",
    lavender = "#B48EAD",
    storm = "#5E81AC",
}

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
