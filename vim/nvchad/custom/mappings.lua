local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<leader>v"] = "",
    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",
    ["gr"] = "", -- using telescope instead of vim.lsp
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

      ["<leader>fm"] = {
        function()
          vim.lsp.buf.format()
        end,
        "format"
      },
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

M.telescope = {
  n = {
    -- this overrides the default which is 
    ["gr"] = {"<cmd> Telescope lsp_references <CR>", "get lsp references"},
  }
}

M.lspconfig = {
  n = {
    ["<F2>"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
    ["<F12>"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    }
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
