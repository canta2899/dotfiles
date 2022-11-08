local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",

  },
  t = {
    -- toggle in terminal mode
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
  },
}

M.general = {
    n = {
      ["d"] = {"\"_d", "delete normal"},
      ["gx"] = {":silent !open <cWORD><cr>",  "open uri"}
    },
    v = {
      ["d"] = {"\"_d", "delete visual"},
      ["<"] = {"<gv", "indent left"},
      [">"] = {">gv", "indent right"},
    }
}

M.tabufline = {
    n = {
        ["<leader>d"] = { "<cmd> bd <CR>", "delete buffer" },
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
