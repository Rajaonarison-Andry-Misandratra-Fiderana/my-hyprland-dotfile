local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- Telescope / File search
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- Oil / File explorer
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Buffer Navigation
vim.keymap.set("n", "<C-b>", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", { desc = "Go to buffer " .. i })
end

-- Swap buffers
vim.keymap.set("n", "<A-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Swap buffer left" })
vim.keymap.set("n", "<A-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Swap buffer right" })

-- Delete buffer pick with leader + b + letter
vim.keymap.set("n", "<leader>ba", "<cmd>BufferLinePickClose<cr>", { desc = "Pick and close buffer" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move right window" })

-- Insert Mode
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("i", "<C-BS>", "<C-w>", opts)
vim.keymap.set("i", "<C-h>", "<C-w>", opts)

-- LSP / Diagnostics
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open diagnostics float" })
vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- Move line/block with Alt + arrows
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", opts)
vim.keymap.set("n", "<A-Left>", "<<", opts)
vim.keymap.set("n", "<A-Right>", ">>", opts)
