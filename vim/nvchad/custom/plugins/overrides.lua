-- overrides defult plugin configs

local function getmasonlist()
    local t = {}
    for _, value in pairs(require 'lsplanguages') do
        t[#t+1] = value.mason
    end

    return t
end


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
  ensure_installed = getmasonlist()
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
