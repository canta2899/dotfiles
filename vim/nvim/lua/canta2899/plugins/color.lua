return {

    -----------------
    -- Tokyonight  --
    -----------------

    {
        "folke/tokyonight.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = { style = "moon" },
        config = function()
            vim.cmd.colorscheme "tokyonight-storm"
        end,
    }


    ---------------
    -- Material  --
    ---------------

    -- {
    --  "marko-cerovac/material.nvim",
    --   priority = 1000,
    --   config = function()
    --     require("material").setup({
    --       disable = {
    --         background = false,
    --       }
    --     })
    --     vim.g.material_style = "darker"
    --     vim.cmd.colorscheme "material"
    --   end
    -- }


    -----------------
    -- Rosepine    --
    -----------------

    -- {
    --   "rose-pine/neovim",
    --   name = "rose-pine",
    --   priority = 1000,
    --   config = function()
    --     require("rose-pine").setup({
    --       variant = "moon",
    --     })
    --     vim.cmd.colorscheme "rose-pine"
    --   end
    -- }
}
