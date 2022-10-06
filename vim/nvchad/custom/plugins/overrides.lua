-- overrides defult plugin configs

local M = {}

M.treesitter = {
	ensure_installed = {
	  "html",
	  "css",
	  "bash",
	  "go",
	  "python",
	  "javascript",
	  "c_sharp",
	  "c",
	  "php",
	  "erlang"
	},
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "emmet-ls",
    "json-lsp",

    "pyright",

    -- shell
    "shfmt",
    "shellcheck",
  },
}

M.alpha = {
  header = {
    val = {
      "         ▄              ▄    ",
      "        ▌▒█           ▄▀▒▌   ",
      "        ▌▒▒█        ▄▀▒▒▒▐   ",
      "       ▐▄█▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐   ",
      "     ▄▄▀▒▒▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐   ",
      "   ▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌   ",
      "  ▐▒▒▒▄▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄▒▌  ",
      "  ▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐  ",
      " ▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌ ",
      " ▌░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌ ",
      "▌▒▒▒▄██▄▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▐ ",
      "▐▒▒▐▄█▄█▌▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▒▒▌",
      "▐▒▒▐▀▐▀▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▐ ",
      " ▌▒▒▀▄▄▄▄▄▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▒▌ ",
      " ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▄▒▒▐  ",
      "  ▀▄▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▄▒▒▒▒▌  ",
      "    ▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀   ",
      "      ▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀     ",
      "         ▀▀▀▀▀▀▀▀▀▀▀▀        ",
    },
  },
}

return M
