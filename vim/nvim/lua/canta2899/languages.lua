-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
--
return {
	{
		name = "c",
		ts = "c",
		lsp = "clangd",
		mason = "clangd",
	},
	-- ["haskell"] = {
	--   ts = "haskell",
	--   lsp = "hls",
	--   mason = "haskell-language-server",
	-- },
	{
		name = "lua",
		ts = "lua",
		lsp = "lua_ls",
		mason = "lua-language-server",
	},
	{
		name = "css",
		ts = "css",
		lsp = "cssls",
		mason = "css-lsp",
	},
	{
		name = "html",
		ts = "html",
		lsp = "html",
		mason = "html-lsp",
	},
	{
		name = "javascript",
		ts = "typescript",
		lsp = "tsserver",
		mason = "typescript-language-server",
	},
	-- ["emmet"] = {
	--   lsp = "emmet_ls",
	--   mason = "emmet-ls",
	-- },
	{
		name = "json",
		ts = "json",
		lsp = "jsonls",
		mason = "json-lsp",
	},
	{
		name = "csharp",
		ts = "c_sharp",
		lsp = "csharp_ls",
		mason = "csharp-language-server",
	},
	-- ["erlang"] = {
	--   ts ="erlang",
	--   lsp = "erlangls",
	--   mason = "erlang-ls"
	-- },
	{
		name = "go",
		ts = "go",
		lsp = "gopls",
		mason = "gopls",
	},
	{
		name = "python",
		ts = "python",
		lsp = "pyright",
		mason = "pyright",
	},
	{
		name = "bash",
		ts = "bash",
		lsp = "bashls",
		mason = "bash-language-server",
	},
	{
		name = "rust",
		ts = "rust",
		lsp = "rust_analyzer",
		mason = "rust-analyzer",
	},
}
