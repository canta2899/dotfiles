local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.env.PATH = vim.fn.expand("~/.nvm/versions/node/v20.18.0/bin") .. ":" .. vim.env.PATH

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("canta2899.settings")
require("canta2899.autocmd")
require("lazy").setup("canta2899.plugins")
require("canta2899.mappings")
