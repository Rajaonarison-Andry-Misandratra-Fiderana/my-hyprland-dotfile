return {
    {
        "nvim-mini/mini.icons",
        version = false,
        lazy = false,
        config = function()
            require("mini.icons").setup()
        end,
    },
}
