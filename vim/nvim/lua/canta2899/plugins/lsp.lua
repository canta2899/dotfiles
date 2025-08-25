local function is_deno_buf(bufnr)
    bufnr = bufnr or 0
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local start = (fname ~= "" and vim.fs.dirname(fname)) or vim.loop.cwd()
    local hits = vim.fs.find({ "deno.json", "deno.jsonc" }, { path = start, upward = true, type = "file" })
    return #hits > 0
end

return {
    {
        "artemave/workspace-diagnostics.nvim",
        config = function()
            vim.api.nvim_set_keymap("n", "<space>d", "", {
                noremap = true,
                callback = function()
                    for _, client in ipairs(vim.lsp.buf_get_clients()) do
                        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
                    end
                end,
            })
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",

        branch = "v2.x",

        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {                            -- Optional
                "williamboman/mason.nvim",
                build = function()
                    pcall(vim.api.nvim_command, "MasonUpdate")
                end,
            },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        },

        config = function()
            local lsp = require("lsp-zero").preset("recommended")
            local lspconfig = require("lspconfig")

            lsp.setup()

            -- Deno project setup
            lspconfig.denols.setup({
                on_attach = lsp.on_attach, -- This attaches your default keybindings, etc.
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            })

            -- Node.js project setup (only attach to Node projects)
            lspconfig.ts_ls.setup({
                on_attach = lsp.on_attach, -- This attaches your default keybindings, etc.
                root_dir = lspconfig.util.root_pattern("package.json"),
                single_file_support = false,
            })


            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()

            cmp.setup({
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                },
                experimental = {
                    ghost_text = true,
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters = {
                    prettier = { require_cwd = true },
                },
                formatters_by_ft = {
                    go = { "goimports", "gofmt" },
                    python = { "black" },

                    -- Deno handles ts/tsx/js/jsx; choose per buffer
                    typescript = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,
                    typescriptreact = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,
                    javascript = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,
                    javascriptreact = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,

                    json = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,
                    yaml = function(bufnr)
                        return is_deno_buf(bufnr) and { "deno_fmt" } or { "prettier" }
                    end,
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    },
    {
        "github/copilot.vim",
    },
}
