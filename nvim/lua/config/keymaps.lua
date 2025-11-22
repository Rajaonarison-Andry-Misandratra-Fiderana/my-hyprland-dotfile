-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "🔍 Find file" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "🔍 Find text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "🔍 Find in buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "🔍 Help" })

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

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
