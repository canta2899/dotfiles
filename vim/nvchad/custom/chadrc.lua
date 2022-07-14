local M = {}

M.options = {
  user = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end,
}

M.plugins = {
    options = {
      lspconfig = {
         setup_lspconf = "custom.lsp",
      },
    },
    user = {
      ["goolord/alpha-nvim"] = {
        disable = false,
      },
    },
    override = {
      ["nvim-treesitter/nvim-treesitter"] = {
        ensure_installed = {
          "html",
          "css",
          "bash",
          "go",
          "python",
          "javascript",
          "c_sharp",
          "c",
          "php",
        },
       },
    },
}

M.ui = {
  theme = "chocolate",
  transparency = true,
}

M.mappings = require "custom.mappings"

return M
