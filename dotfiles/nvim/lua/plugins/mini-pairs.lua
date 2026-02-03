return {
    "andymass/vim-matchup",
    event = "CursorMoved", -- se charge quand tu bouges le curseur
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" } -- optionnel : popup si hors écran
        vim.g.matchup_matchparen_hi_surround_always = 1 -- met en surbrillance tout le bloc
    end,
}
