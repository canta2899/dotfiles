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
            require("nvterm.terminal").toggle "float"
         end,
         "   toggle floating term",
      },

      ["<C-h>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle horizontal term",
      },

      ["<C-v>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   toggle vertical term",
      },
   },

   n = {
      -- toggle in normal mode
      ["<C-t>"] = {
         function()
            require("nvterm.terminal").toggle "float"
         end,
         "   toggle floating term",
      },

      ["<C-h>"] = {
         function()
            require("nvterm.terminal").toggle "horizontal"
         end,
         "   toggle horizontal term",
      },

      ["<C-v>"] = {
         function()
            require("nvterm.terminal").toggle "vertical"
         end,
         "   toggle vertical term",
      },
   },
}

return M
