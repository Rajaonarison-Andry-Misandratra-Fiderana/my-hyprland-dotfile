return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },

        enable_search_in_input = true,
        search_in_input = {
            debounce = 100,
            clear_on_close = true,
        },

        filesystem = {
            delete_to_trash = true,
            bind_to_cwd = true, -- Neo-tree suit toujours le cwd actif
            follow_current_file = {
                enabled = true, -- suit le buffer actif
                leave_dirs_open = true, -- laisse les dossiers ouverts
                highlight = "NeoTreeFileNameCurrent",
            },
            use_libuv_file_watcher = true,

            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    "node_modules",
                    ".git",
                    ".cache",
                    ".DS_Store",
                    "thumbs.db",
                },
            },
        },

        window = {
            position = "right",
            width = 35,
        },

        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "",
            },
            git_status = {
                symbols = {
                    unstaged = "󰄱",
                    staged = "󰱒",
                },
            },
        },
    },
}
