-- =========================================
-- CORE & OPTIONS
-- =========================================
require("config.lazy")
local keymap = require("vim.keymap")

vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.smartindent = true
vim.opt.wrap = true

vim.cmd.colorscheme("no-clown-fiesta")

-- =========================================
-- LUASNIP
-- =========================================
require("luasnip.loaders.from_vscode").lazy_load()

-- =========================================
-- TELESCOPE
-- =========================================
require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        path_display = { "smart" },
        file_ignore_patterns = { "node_modules", ".git", "target", "build", "dist", "__pycache__" },
    },
})

-- =========================================
-- OIL (FILE EXPLORER)
-- =========================================
require("oil").setup({
    default_file_explorer = true,
    columns = { "icon" },
    keymaps = {
        ["h"] = "actions.parent",
        ["l"] = "actions.select",
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
        show_hidden = true,
        natural_order = "fast",
        sort = { { "type", "asc" }, { "name", "asc" } },
    },
    preview_win = { update_on_cursor_moved = true, preview_method = "fast_scratch" },
})

-- =========================================
-- TINY INLINE DIAGNOSTIC
-- =========================================
require("tiny-inline-diagnostic").setup({
    preset = "ghost",
    transparent_bg = true,
    transparent_cursorline = true,
    hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "CursorLine",
        mixing_color = "Normal",
    },
    options = {
        show_source = { enabled = false, if_many = false },
        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = true,
        throttle = 50,
        softwrap = 10,
        add_messages = { messages = true, display_count = false, use_max_severity = false, show_multiple_glyphs = true },
        multilines = { enabled = false, always_show = true, trim_whitespaces = true, tabstop = 4 },
        show_all_diags_on_cursorline = true,
        show_diags_only_under_cursor = false,
        show_related = { enabled = true, max_count = 5 },
        enable_on_insert = false,
        enable_on_select = false,
        overflow = { mode = "wrap", padding = 0 },
        break_line = { enabled = true, after = 30 },
        virt_texts = { priority = 2048 },
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },
        override_open_float = true,
    },
})
require("hbac").setup({
    autoclose = true, -- set autoclose to false if you want to close manually
    threshold = 5, -- hbac will start closing unedited buffers once that number is reached
    close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
    end,
    close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
    telescope = {
        -- See #telescope-configuration below
    },
})
