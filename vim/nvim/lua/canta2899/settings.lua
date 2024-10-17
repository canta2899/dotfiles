vim.g.mapleader = " "

----- Netrw -----

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3

-----------------

vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
-- vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 8

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

vim.opt.shortmess:append("sI")
-- vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50
vim.opt.undofile = true

vim.opt.updatetime = 250
vim.opt.whichwrap:append("<>[]hl")
vim.opt.linebreak = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- disables providers
-- vim.g["loaded_" .. provider .. "_provider"] = 0

-- mason binaries
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
-- vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
