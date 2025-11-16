return {
    "gbprod/yanky.nvim",
    dependencies = {
        { "kkharji/sqlite.lua" },
        { "nvim-telescope/telescope.nvim" },
    },
    opts = {
        ring = {
            history_length = 100,
            storage = "sqlite",
            sync_with_numbered_registers = true,
        },
        system_clipboard = {
            sync_with_ring = true,
        },
        highlight = {
            on_put = true,
            on_yank = true,
            timer = 700,
        },
        picker = {
            telescope = {
                use_default_mappings = true,
            },
        },
    },
    keys = {
        -- Historique complet via Telescope
        { "<leader>p", "<cmd>Telescope yank_history<cr>", mode = { "n", "x" }, desc = "Open Yank History (Telescope)" },

        -- Yank
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },

        -- Put
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
        { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
        { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
        { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },

        -- Navigation historique
        { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous yank entry" },
        { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next yank entry" },

        -- Indentation et filtres
        { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after (linewise)" },
        { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before (linewise)" },
        { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after (linewise)" },
        { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before (linewise)" },
        { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
        { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
        { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
        { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
        { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
        { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
}
