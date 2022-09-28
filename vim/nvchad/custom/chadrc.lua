local M = {}

M.options = {
  user = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end,
}

M.plugins = require "custom.plugins"

M.ui = {
  theme = "chocolate",
  transparency = false,
}

M.mappings = require "custom.mappings"

return M
