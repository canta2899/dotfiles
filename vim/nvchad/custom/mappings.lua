local M = {}

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
