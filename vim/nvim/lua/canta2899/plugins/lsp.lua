local languages = require("canta2899.languages")
local servers = {}
for _, value in pairs(languages) do
    if value.lsp then
        servers[#servers + 1] = value.lsp
    end
end

local function isdeno()
    return vim.loop.fs_stat(vim.loop.cwd() .. "/deno.json") ~= nil
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
            local lsp = require("lsp-zero").preset({})
            local lspconfig = require("lspconfig")

            -- Deno project setup
            lspconfig.denols.setup({
                on_attach = lsp.on_attach, -- This attaches your default keybindings, etc.
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            })

            -- Node.js project setup (only attach to Node projects)
            lspconfig.ts_ls.setup({
                on_attach = lsp.on_attach,  -- This attaches your default keybindings, etc.
                root_dir = lspconfig.util.root_pattern("package.json"),
                single_file_support = true, -- Disable tsserver for single files (helps prevent conflicts with Deno)
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

            lsp.preset("recommended")
            lsp.setup()
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {},
        config = function()
            require("conform").setup({
                formatters = {
                    prettier = {
                        require_cwd = true,
                    },
                },
                formatters_by_ft = {

                    go = { "goimports", "gofmt" },

                    python = { "black" },

                    javascript = { "prettier" },

                    json = { "prettier" },

                    yaml = { "prettier" },

                    typescript = function()
                        if isdeno() then
                            return { "deno_fmt" }
                        else
                            return { "prettier" }
                        end
                    end,

                    typescriptreact = function()
                        if isdeno() then
                            return { "deno_fmt" }
                        else
                            return { "prettier" }
                        end
                    end,

                    javascriptreact = { "prettier" },
                },
                format_on_save = {
                    -- These options will be passed to conform.format()
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
