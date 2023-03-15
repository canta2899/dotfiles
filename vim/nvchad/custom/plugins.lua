local overrides = require "custom.configs.overrides"

return {

  {"whonore/Coqtail",
    ft = {'v'},
    cmd = {'CoqStart'},
    config = function()
      vim.cmd("hi CoqtailChecked guibg=#333333")
      vim.cmd("hi CoqtailSent    guibg=#333333")
    end,
  },

  {"williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {"neovim/nvim-lspconfig",
    dependencies = {

      {"jose-elias-alvarez/null-ls.nvim",
        config = function()
         require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {"nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
}
