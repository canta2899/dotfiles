local overrides = require "custom.plugins.overrides"

return {

  ['whonore/Coqtail'] = {
    config = function()
      vim.cmd("hi CoqtailChecked guifg=Green guibg=#333333 gui=bold")
      vim.cmd("hi CoqtailSent    guifg=Green guibg=#333333 gui=bold")
    end,
  },

  ['folke/which-key.nvim'] = {
    disable = true
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
