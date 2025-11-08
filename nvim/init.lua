-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd.colorscheme("nordic")
vim.opt.termguicolors = true
require("bufferline").setup({})
