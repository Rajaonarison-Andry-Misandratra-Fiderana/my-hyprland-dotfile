-- ==========================================================================
-- BOOTSTRAP LAZY
-- ==========================================================================
require("config.lazy")

-- ==========================================================================
-- VIM OPTIONS
-- ==========================================================================
local opt = vim.opt

-- Apparence & Interface
opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.wrap = false -- pas de line wrap sur du code
opt.linebreak = true -- wrap sur les mots si activé ponctuellement
opt.signcolumn = "yes:4" -- 1 colonne suffit avec statuscol.nvim
opt.scrolloff = 8 -- contexte vertical au scroll
opt.sidescrolloff = 8 -- contexte horizontal
opt.splitright = true -- vsplit à droite
opt.splitbelow = true -- hsplit en bas
opt.showmode = false -- inutile avec une statusline

-- Fichiers & Historique
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true -- undo persistant entre sessions
opt.clipboard = "unnamedplus" -- sync avec clipboard système

-- Performance
opt.updatetime = 200 -- réduit délai CursorHold (LSP, gitsigns)
opt.timeoutlen = 300 -- délai keymaps (whichkey friendly)
opt.lazyredraw = false -- laisser false avec Neovim moderne

-- Indentation
opt.smartindent = true
opt.expandtab = true -- espaces au lieu de tabs
opt.shiftwidth = 2 -- indentation 2 espaces (React/TS standard)
opt.tabstop = 2
opt.softtabstop = 2

-- Recherche
opt.ignorecase = true
opt.smartcase = true -- sensible à la casse si majuscule présente
opt.hlsearch = false -- pas de highlight persistant après recherche
opt.incsearch = true

-- ==========================================================================
-- THÈME
-- ==========================================================================
vim.cmd.colorscheme("carbonfox")

-- Numéros de ligne : couleur dim kanagawa (fujiGray) au lieu de blanc pur
vim.api.nvim_set_hl(0, "LineNr", { fg = "#54546D" })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#54546D" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#54546D" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DCA561", bold = true })

-- ==========================================================================
-- DIAGNOSTICS
-- ==========================================================================
vim.diagnostic.config({
  virtual_text = false, -- désactivé : tiny-inline-diagnostic s'en charge
  signs = true,
  underline = true,
  update_in_insert = false, -- pas de diagnostics pendant la frappe
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- ==========================================================================
-- PLUGINS
-- ==========================================================================

-- --------------------------------------------------------------------------
-- OIL (File Explorer)
-- --------------------------------------------------------------------------
require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  keymaps = {
    ["h"] = "actions.parent",
    ["<Left>"] = "actions.parent",
    ["l"] = "actions.select",
    ["<Right>"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["g."] = "actions.toggle_hidden",
  },
  view_options = {
    show_hidden = true,
    sort = {
      { "type", "asc" },
      { "name", "asc" },
    },
  },
})

-- --------------------------------------------------------------------------
-- TELESCOPE (Fuzzy Finder)
-- --------------------------------------------------------------------------
require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = { prompt_position = "top" },
    path_display = { "smart" },
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "target/",
      "dist/",
      "build/",
      ".next/",
    },
  },
})

-- --------------------------------------------------------------------------
-- TINY INLINE DIAGNOSTIC (LSP UI)
-- --------------------------------------------------------------------------
require("tiny-inline-diagnostic").setup({
  preset = "ghost",
  options = {
    throttle = 50,
    show_all_diags_on_cursorline = true,
    break_line = {
      enabled = true,
      after = 30,
    },
    -- severity non filtré : virtual_text=false gère déjà la déduplication
  },
})
-- --------------------------------------------------------------------------
-- HBAC (Heuristic Buffer Auto-Close)
-- --------------------------------------------------------------------------
require("hbac").setup({
  autoclose = true,
  threshold = 5,
  close_command = function(bufnr)
    vim.api.nvim_buf_delete(bufnr, {})
  end,
  close_buffers_with_windows = false,
})

-- --------------------------------------------------------------------------
-- BUFFERLINE
-- --------------------------------------------------------------------------
require("bufferline").setup({
  options = {
    mode = "buffers",
    numbers = "ordinal",
    separator_style = "thin",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    diagnostics = "nvim_lsp",
    offsets = {
      { filetype = "oil", text = "Explorer", text_align = "center" },
    },
  },
  highlights = {
    buffer_selected = { fg = "#ffffff", bg = "#2d2f4a", bold = true },
    buffer_visible = { fg = "#a0a0a0", bg = "#1f1f2a" },
    buffer = { fg = "#888888", bg = "#1f1f2a" },
    separator = { fg = "#44475a", bg = "#1f1f2a" },
    separator_selected = { fg = "#2d2f4a", bg = "#2d2f4a" },
    close_button = { fg = "#888888", bg = "#1f1f2a" },
    close_button_visible = { fg = "#a0a0a0", bg = "#1f1f2a" },
    close_button_selected = { fg = "#ffffff", bg = "#2d2f4a" },
  },
})

-- --------------------------------------------------------------------------
-- COMPLETION (nvim-cmp + luasnip)
-- --------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 750 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
