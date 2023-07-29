return {

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            local indent = require("indent_blankline")

            indent.setup {
                show_end_of_line = false,
            }
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter.configs")
            local parsers = require("canta2899.utils").get_language("ts")

            ts.setup {
                ensure_installed = parsers,
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },

                indent = { enable = true },
            }
        end,
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local autopairs = require("nvim-autopairs")

            autopairs.setup {
                fast_wrap = {},
                disable_filetype = { "TelescopePrompt", "vim" }
            }
        end,
    },
}
