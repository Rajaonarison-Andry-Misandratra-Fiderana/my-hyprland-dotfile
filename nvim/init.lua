-- =========================================
-- 🧩 BOOTSTRAP
-- =========================================
require("config.lazy")
require("luasnip.loaders.from_vscode").lazy_load()

-- =========================================
-- ⚙️ CONFIGURATION GLOBALE
-- =========================================
vim.opt.termguicolors = true
vim.opt.mouse = "" -- désactive la souris
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.cmd([[colorscheme no-clown-fiesta]])

require("no-clown-fiesta").setup({
    theme = "dark",
    transparent = false,
    styles = {
        comments = {},
        functions = {},
        keywords = {},
        lsp = {},
        match_paren = {},
        type = {},
        variables = {},
    },
})
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

lualine.setup({

    options = {
        icons_enabled = true,
        theme = {
            normal = {
                a = { bg = colors.polar, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.frost },
                c = { bg = colors.bg, fg = colors.snow },
            },
            insert = {
                a = { bg = colors.pine, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.pine },
            },
            visual = {
                a = { bg = colors.gold, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.gold },
            },
            replace = {
                a = { bg = colors.aurora, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.aurora },
            },
            command = {
                a = { bg = colors.lavender, fg = colors.bg, gui = "bold" },
                b = { bg = colors.bg, fg = colors.lavender },
            },
            inactive = {
                a = { bg = colors.bg, fg = colors.storm },
                b = { bg = colors.bg, fg = colors.storm },
                c = { bg = colors.bg, fg = colors.storm },
            },
        },
        component_separators = { left = "󰇙", right = "󰇙" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "", right = "" }, padding = { left = 1, right = 1 } },
        },
        lualine_b = {
            {
                "branch",
                icon = "󰊢", -- Icône Git
                color = { fg = colors.snow, gui = "bold" },
            },
        },
        lualine_c = {
            {
                "filename",
                file_status = true,
                path = 1,
                symbols = { modified = " 󰏫", readonly = " 󰌾" },
                color = { fg = colors.snow },
            },
        },
        lualine_x = {
            {
                "encoding",
                icon = "󰃭",
                color = { fg = colors.frost },
            },
            {
                "filetype",
                icon_only = true,
                colored = true,
                padding = { left = 1, right = 0 },
            },
            {
                "fileformat",
                icons_enabled = true,
                symbols = {
                    unix = "", -- Linux
                    dos = "󰖳", -- Windows
                    mac = "󰀵", -- Mac
                },
                color = { fg = colors.frost },
            },
        },
        lualine_y = {
            {
                "progress",
                color = { fg = colors.snow },
                padding = { left = 1, right = 1 },
            },
        },
        lualine_z = {
            {
                "location",
                color = { fg = colors.bg, bg = colors.frost, gui = "bold" },
                separator = { left = "", right = "" },
                padding = { left = 1, right = 1 },
            },
        },
    },
    inactive_sections = {
        lualine_a = {
            {
                "filename",
                file_status = true,
                path = 1,
                color = { fg = colors.storm },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            {
                "location",
                color = { fg = colors.storm },
            },
        },
    },
    tabline = {},
    extensions = { "fugitive", "nvim-tree", "toggleterm" },
})
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
