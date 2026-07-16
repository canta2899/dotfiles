return {
  -- Kanagawa theme
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = false,
      theme = "lotus",
      background = {
        dark = "wave",
        light = "lotus",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
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
      opts.inlay_hints = { enabled = false }
      opts.servers = opts.servers or {}
      opts.servers.marksman = { enabled = false }
      opts.servers.ruff = { mason = false }
      opts.servers.basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              diagnosticSeverityOverrides = {
                reportArgumentType = "none",
                reportAssignmentType = "none",
                reportReturnType = "none",
                reportGeneralTypeIssues = "none",
                reportUnknownArgumentType = "none",
                reportUnknownMemberType = "none",
                reportUnknownVariableType = "none",
                reportUnknownParameterType = "none",
                reportMissingTypeStubs = "none",
                reportAny = "none",
                reportExplicitAny = "none",
              },
            },
          },
        },
      }
    end,
  },

  -- Bash LSP (no LazyVim extra available)
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "bash-language-server", "shfmt", "basedpyright" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = { bashls = {} },
    },
  },
}
