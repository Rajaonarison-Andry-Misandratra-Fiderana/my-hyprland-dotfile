return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
        modes = {
            jump = {
                multi_char = true, -- active les séquences de 2+ lettres si nécessaire
                highlight = { backdrop = true }, -- visibilité des cibles
            },
            search = {
                multi_char = true,
            },
        },
        search = {
            max_length = 2, -- limite le nombre de lettres par target
            incremental = true, -- jump dynamique si pattern trouvé
        },
    },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    { "<c-space>", mode = { "n", "o", "x" },
      function()
        require("flash").treesitter({
          actions = {
            ["<c-space>"] = "next",
            ["<BS>"] = "prev"
          }
        }) 
      end, desc = "Treesitter Incremental Selection" },
  },
}
