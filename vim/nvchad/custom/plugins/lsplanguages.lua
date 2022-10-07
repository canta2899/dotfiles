-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

return {
    ["lua"] = {
        lsp = "sumneko_lua";
        mason = "lua-language-server",
    },
    ["css"] = {
        lsp = "cssls",
        mason = "css-lsp",
    },
    ["html"] = {
        lsp = "html",
        mason = "html-lsp",
    },
    ["javascript"] = {
        lsp = "tsserver",
        mason = "typescript-language-server",
    },
    ["deno"] = {
        lsp = "denols",
        mason = "deno",
    },
    ["emmet"] = {
        lsp = "emmet_ls",
        mason = "emmet-ls",
    },
    ["json"] = {
        lsp = "jsonls",
        mason = "json-lsp",
    },
    ["c"] = {
        lsp = "clangd",
        mason = "clangd",
    },
    ["erlang"] = {
        lsp = "erlangls",
        mason = "erlang-ls"
    },
    ["go"] = {
        lsp = "gopls",
        mason = "gopls"
    },
    ["python"] = {
        lsp = "pyright",
        mason = "pyright",
    },
    ["bash"] = {
        lsp = "bashls",
        mason = "bash-language-server",
    },
}