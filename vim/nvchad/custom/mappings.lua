local M = {}

M.disabled = {
    n = {
        ["<leader>h"] = "",
        ["<leader>v"] = "",
    }
}

M.general = {
    n = {
      ["d"] = {"\"_d", "delete normal"},
    },
    v = {
      ["d"] = {"\"_d", "delete visual"},
      ["<"] = {"<gv", "indent left"},
      [">"] = {">gv", "indent right"},
    }
}

M.tabufline = {
    n = {
        ["<leader>x"] = { "<cmd> bd <CR>", "delete buffer" },
    },
}

M.nvterm = {
   t = {
      -- toggle in terminal mode
      ["<C-t>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle floating term",
      },

      -- should find some combination to also toggle "float"
   },

   n = {
      -- toggle in normal mode
      ["<C-t>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle floating term",
      },

      -- should find some combination to also toggle "float"
   },
}

return M
