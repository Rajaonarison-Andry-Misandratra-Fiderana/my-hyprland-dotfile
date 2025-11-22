return {
  "adibhanna/laravel.nvim",
  lazy = true,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>la", ":Artisan<cr>", desc = "Laravel Artisan" },
    { "<leader>lc", ":Composer<cr>", desc = "Composer" },
    { "<leader>lr", ":LaravelRoute<cr>", desc = "Laravel Routes" },
    { "<leader>lm", ":LaravelMake<cr>", desc = "Laravel Make" },
  },
  config = function()
    require("laravel").setup({
      notifications = false, -- Enable/disable Laravel.nvim notifications (default: true)
      debug = false, -- Enable/disable debug error notifications (default: false)
      keymaps = false, -- Enable/disable Laravel.nvim keymaps (default: true)
      sail = {
        enabled = true, -- Enable/disable Laravel Sail integration (default: true)
        auto_detect = true, -- Auto-detect Sail usage in project (default: true)
      },
    })
  end,
}
