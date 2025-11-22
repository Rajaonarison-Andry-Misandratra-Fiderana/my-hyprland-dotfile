return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            bacon_ls = {
                enabled = diagnostics == "bacon-ls",
            },
            rust_analyzer = { enabled = false },
        },
    },
}
