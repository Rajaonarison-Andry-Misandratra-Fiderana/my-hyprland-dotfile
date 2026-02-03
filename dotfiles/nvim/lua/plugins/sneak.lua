return {
    -- Sneak pour jump rapide
    {
        "justinmk/vim-sneak",
        event = "VeryLazy", -- charge au moment opportun
        config = function()
            -- options pour répéter avec ; et ,
            vim.g["sneak#s_next"] = ";"
            vim.g["sneak#s_prev"] = ","
        end,
    },
}
