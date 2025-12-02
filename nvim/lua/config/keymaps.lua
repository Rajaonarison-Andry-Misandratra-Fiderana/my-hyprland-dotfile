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
end)

vim.keymap.set("n", "<C-b>", "<cmd>BufferLinePick<cr>")
vim.keymap.set("n", "<C-A-1>", "<cmd>BufferLineGoToBuffer 1<cr>")
vim.keymap.set("n", "<C-A-2>", "<cmd>BufferLineGoToBuffer 2<cr>")
vim.keymap.set("n", "<C-A-3>", "<cmd>BufferLineGoToBuffer 3<cr>")
vim.keymap.set("n", "<C-A-4>", "<cmd>BufferLineGoToBuffer 4<cr>")
vim.keymap.set("n", "<C-A-5>", "<cmd>BufferLineGoToBuffer 5<cr>")
vim.keymap.set("n", "<C-A-6>", "<cmd>BufferLineGoToBuffer 6<cr>")
vim.keymap.set("n", "<C-A-7>", "<cmd>BufferLineGoToBuffer 7<cr>")
vim.keymap.set("n", "<C-A-8>", "<cmd>BufferLineGoToBuffer 8<cr>")
vim.keymap.set("n", "<C-A-9>", "<cmd>BufferLineGoToBuffer 9<cr>")
