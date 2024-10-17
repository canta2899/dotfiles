local languages = require("canta2899.languages")
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

local new_cmd = vim.api.nvim_create_user_command

new_cmd("EnsureLsp", function()
	local utils = require("canta2899.utils")
	local servers = utils.get_language("lsp")
	print(table.concat(servers, " "))
	require("mason-lspconfig").setup({ ensure_installed = servers })
end, {})

autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})
