return {
  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = false,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },

  -- Disable noice (centered cmdline)
  { "folke/noice.nvim", enabled = false },

  -- Disable snacks notifications
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { enabled = false },
      dashboard = { enabled = false },
      scroll = { enabled = true },
      terminal = {
        win = {
          position = "float",
          padding = 10,
        },
      },
      picker = {
        sources = {
          explorer = {
            actions = {
              close_explorer = function(picker)
                picker:close()
              end,
            },
            win = {
              list = {
                keys = {
                  ["<C-n>"] = "close_explorer",
                },
              },
            },
          },
        },
      },
    },
  },

  -- Format on save via ruff
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
      },
    },
  },

  -- Use system ruff (installed via uv tool install ruff) instead of Mason's
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.marksman = { enabled = false }
      opts.servers.ruff = { mason = false }

      -- Register ty (not in nvim-lspconfig defaults yet)
      local configs = require("lspconfig.configs")
      if not configs.ty then
        configs.ty = {
          default_config = {
            cmd = { "ty", "server" },
            filetypes = { "python" },
            root_dir = require("lspconfig.util").root_pattern(
              "pyproject.toml",
              "ty.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              ".git"
            ),
            single_file_support = true,
            settings = {},
          },
        }
      end
      opts.servers.ty = { mason = false }
    end,
  },

  -- Bash LSP (no LazyVim extra available)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "bash-language-server", "shfmt" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { bashls = {} },
    },
  },
}
