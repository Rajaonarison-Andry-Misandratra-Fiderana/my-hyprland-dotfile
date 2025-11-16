return {
    "kr40/nvim-macros",
    cmd = { "MacroSave", "MacroYank", "MacroSelect", "MacroDelete" },
    opts = {

        json_file_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/macros.json"), -- Location where the macros will be stored
        default_macro_register = "q", -- Use as default register for :MacroYank and :MacroSave and :MacroSelect Raw functions
        json_formatter = "jq", -- can be "none" | "jq" | "yq" used to pretty print the json file (jq or yq must be installed!)
    },
}
