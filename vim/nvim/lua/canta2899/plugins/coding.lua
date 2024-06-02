return {

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
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
