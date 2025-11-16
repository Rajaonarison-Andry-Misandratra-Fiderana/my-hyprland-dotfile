-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- luasnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function()
    ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
    ls.jump(-1)
end, { silent = true })

vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "🔍 Rechercher fichiers" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "🔍 Rechercher texte" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "🔍 Rechercher buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "🔍 Aide" })

-- Buffers navigation
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "➡️ Buffer suivant" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "⬅️ Buffer précédent" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "🗑️ Fermer buffer" })
