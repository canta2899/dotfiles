return {
  -- Nordic theme
  {
    "AlexvZyl/nordic.nvim",
    opts = {
      transparent = {
        bg = false,
        float = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
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
    opts = {
      servers = {
        marksman = { enabled = false },
        ruff = { mason = false },
        -- should source the environment before starting the server
        pyright = {
          before_init = function(_, config)
            local venv = vim.fn.getcwd() .. "/.venv"
            if vim.fn.isdirectory(venv) == 1 then
              config.settings = config.settings or {}
              config.settings.python = vim.tbl_deep_extend("force", config.settings.python or {}, {
                pythonPath = venv .. "/bin/python",
                venvPath = vim.fn.getcwd(),
                venv = ".venv",
              })
            end
          end,
        },
      },
    },
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
