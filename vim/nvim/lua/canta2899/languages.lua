-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
--
return {
  ["C"] = {
    ts = "c",
    lsp = "clangd",
    mason = "clangd",
  },
  -- ["haskell"] = {
  --   ts = "haskell",
  --   lsp = "hls",
  --   mason = "haskell-language-server",
  -- },
  ["lua"] = {
    ts = "lua",
    lsp = "lua_ls",
    mason = "lua-language-server",
  },
  -- ["css"] = {
  --   ts = "css",
  --   lsp = "cssls",
  --   mason = "css-lsp",
  -- },
  -- ["html"] = {
  --   ts = "html",
  --   lsp = "html",
  --   mason = "html-lsp",
  -- },
  ["javascript"] = {
    ts = "typescript",
    lsp = "tsserver",
    mason = "typescript-language-server",
  },
  -- ["deno"] = {
  --   ts = "typescript",
  --   lsp = "denols",
  --   mason = "deno",
  -- },
  -- ["emmet"] = {
  --   lsp = "emmet_ls",
  --   mason = "emmet-ls",
  -- },
  -- ["json"] = {
  --   ts = "json",
  --   lsp = "jsonls",
  --   mason = "json-lsp",
  -- },
  -- ["csharp"] = {
  --   ts = "c_sharp",
  --   lsp = "csharp_ls",
  --   mason = "csharp-language-server",
  -- },
  -- ["erlang"] = {
  --   ts ="erlang",
  --   lsp = "erlangls",
  --   mason = "erlang-ls"
  -- },
  ["go"] = {
    ts = "go",
    lsp = "gopls",
    mason = "gopls"
  },
  -- ["python"] = {
  --   ts = "python",
  --   lsp = "pyright",
  --   mason = "pyright",
  -- },
  -- ["bash"] = {
  --   ts = "bash",
  --   lsp = "bashls",
  --   mason = "bash-language-server",
  -- },
  -- ["rust_analyzer"] = {
  --   ts = "rust",
  --   lsp = "rust_analyzer",
  --   mason = "rust-analyzer"
  -- }
}

