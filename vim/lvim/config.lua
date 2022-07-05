-- custom lunar vim configuration in lua
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

lvim.keys.normal_mode["ss"] = ":split .<Return>"

lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-A-Left"] = ":resize -2<CR>"
lvim.keys.normal_mode["<C-A-Left"] = ":resize -2<CR>"

vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd("set wrap")

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["ss"] = ":vsplit ./<cr>"
lvim.keys.normal_mode["<A-Up>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<A-Down>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<A-Left>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["<A-Right>"] = ":vertical resize +2<CR>"
lvim.keys.normal_mode["d"] = "\"_d" -- real delete instead of cut
lvim.keys.normal_mode["mn"] = ":Minimap<CR>"

-- https://github.com/LunarVim/LunarVim/issues/1857
lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.visual_block_mode["<A-j>"] = false
lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false

lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
}

-- https://github.com/LunarVim/lunarvim.org/pull/152
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.snippets = {
    markdown = {
        s("pandocimg", {
			t({
                "\\begin{figure}[H]",
                "\\centering",
                "\\includegraphics[width=250px]{}",
                "\\end{figure}"
            }),
		}),
    },
}

lvim.transparent_window = true


require("lspconfig").gopls.setup{}

-- Additional Plugins
lvim.plugins = {
    {"lervag/vimtex"},
    {"ctrlpvim/ctrlp.vim"},
}

-- To set commands with specific triggers according to the file type
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.md", "set nospell" }
-- }

