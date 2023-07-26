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
            local languages = require("canta2899.languages")
            local installed = {}

            for _, value in pairs(languages) do
                if value.ts then installed[#installed+1] = value.ts end
            end


            ts.setup {
                ensure_installed = installed,
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
