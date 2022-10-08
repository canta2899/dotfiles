local overrides = require "custom.plugins.overrides"

return {

  ['folke/which-key.nvim'] = {
    disable = false
  },

  ["goolord/alpha-nvim"] = {
    disable = false,
    override_options = overrides.alpha,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

 ["jose-elias-alvarez/null-ls.nvim"] = {
   after = "nvim-lspconfig",
   config = function()
     require "custom.plugins.null-ls"
   end,
 },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
     override_options = overrides.treesitter,
   },

}
