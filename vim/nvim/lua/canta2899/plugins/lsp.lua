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
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = function()
            return {
                PATH = "skip",

                ui = {
                    icons = {
                        package_pending = " ",
                        package_installed = " ",
                        package_uninstalled = " ",
                    },
                },

                max_concurrent_installers = 10,
            }
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
        config = function()
            local M = {}
            local map = vim.keymap.set

            -- export on_attach & capabilities
            M.on_attach = function(_, bufnr)
                local function opts(desc)
                    return { buffer = bufnr, desc = "LSP " .. desc }
                end

                map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts "List workspace folders")

                map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
                map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
            end

            -- disable semanticTokens
            M.on_init = function(client, _)
                if vim.fn.has "nvim-0.11" ~= 1 then
                    if client.supports_method "textDocument/semanticTokens" then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                else
                    if client:supports_method "textDocument/semanticTokens" then
                        client.server_capabilities.semanticTokensProvider = nil
                    end
                end
            end

            M.capabilities = vim.lsp.protocol.make_client_capabilities()

            M.capabilities.textDocument.completion.completionItem = {
                documentationFormat = { "markdown", "plaintext" },
                snippetSupport = true,
                preselectSupport = true,
                insertReplaceSupport = true,
                labelDetailsSupport = true,
                deprecatedSupport = true,
                commitCharactersSupport = true,
                tagSupport = { valueSet = { 1 } },
                resolveSupport = {
                    properties = {
                        "documentation",
                        "detail",
                        "additionalTextEdits",
                    },
                },
            }

            M.defaults = function()
                dofile(vim.g.base46_cache .. "lsp")
                require("nvchad.lsp").diagnostic_config()

                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        M.on_attach(_, args.buf)
                    end,
                })

                local lua_lsp_settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            library = {
                                vim.fn.expand "$VIMRUNTIME/lua",
                                vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                                vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                                "${3rd}/luv/library",
                            },
                        },
                    },
                }

                -- Support 0.10 temporarily

                if vim.lsp.config then
                    vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init })
                    vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
                    vim.lsp.enable "lua_ls"
                else
                    require("lspconfig").lua_ls.setup {
                        capabilities = M.capabilities,
                        on_init = M.on_init,
                        settings = lua_lsp_settings,
                    }
                end
            end

            return M
        end,
    },

    -- load luasnips + cmp related in insert mode only
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "https://codeberg.org/FelipeLema/cmp-async-path.git"
            }
        },
        opts = function()
            local cmp = require "cmp"

            local options = {
                completion = { completeopt = "menu,menuone" },

                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                mapping = {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),

                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif require("luasnip").expand_or_jumpable() then
                            require("luasnip").expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif require("luasnip").jumpable(-1) then
                            require("luasnip").jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "nvim_lua" },
                    { name = "async_path" },
                },
            }

            return vim.tbl_deep_extend("force", options, require "nvchad.cmp")
        end,
    },
    -- {
    --     "VonHeikemen/lsp-zero.nvim",

    --     branch = "v2.x",

    --     dependencies = {
    --         -- LSP Support
    --         { "neovim/nvim-lspconfig" }, -- Required
    --         {                            -- Optional
    --             "williamboman/mason.nvim",
    --             build = function()
    --                 pcall(vim.api.nvim_command, "MasonUpdate")
    --             end,
    --         },
    --         { "williamboman/mason-lspconfig.nvim" },
    --         -- Autocompletion
    --         { "hrsh7th/nvim-cmp" },     -- Required
    --         { "hrsh7th/cmp-nvim-lsp" }, -- Required
    --         { "L3MON4D3/LuaSnip" },     -- Required
    --     },

    --     config = function()
    --         local lsp = require("lsp-zero").preset("recommended")
    --         local lspconfig = require("lspconfig")

    --         lsp.setup()

    --         -- Deno project setup
    --         lspconfig.denols.setup({
    --             on_attach = lsp.on_attach, -- This attaches your default keybindings, etc.
    --             root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    --         })

    --         -- Node.js project setup (only attach to Node projects)
    --         lspconfig.ts_ls.setup({
    --             on_attach = lsp.on_attach, -- This attaches your default keybindings, etc.
    --             root_dir = lspconfig.util.root_pattern("package.json"),
    --             single_file_support = false,
    --         })


    --         lsp.on_attach(function(_, bufnr)
    --             lsp.default_keymaps({ buffer = bufnr })
    --         end)

    --         local cmp = require("cmp")
    --         local cmp_action = require("lsp-zero").cmp_action()

    --         cmp.setup({
    --             mapping = {
    --                 ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --                 ["<C-Space>"] = cmp.mapping.complete(),
    --                 ["<C-f>"] = cmp_action.luasnip_jump_forward(),
    --                 ["<C-b>"] = cmp_action.luasnip_jump_backward(),
    --             },
    --             experimental = {
    --                 ghost_text = true,
    --             },
    --             snippet = {
    --                 expand = function(args)
    --                     require("luasnip").lsp_expand(args.body)
    --                 end,
    --             },
    --         })
    --     end,
    -- },
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
