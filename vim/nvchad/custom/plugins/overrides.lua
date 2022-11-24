-- overrides defult plugin configs

local lsplanguages = require "custom.plugins.lsplanguages"

local function getmasonlist()
    local t = {}
    for _, value in pairs(lsplanguages) do
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
	  "erlang",
    "ocaml"
	},
}

M.mason = {
  ensure_installed = getmasonlist()
}

M.alpha = {
  header = {
    val = {
      "                            _              ",
      "                           (_)             ",
      "      ____   ____ ___ _   _ _ ____         ",
      "     |  _ \\ / _  ) _ \\ | | | |    \\     ",
      "     | | | ( (/ / |_| \\ V /| | | | |      ",
      "     |_| |_|\\____)___/ \\_/ |_|_|_|_|     ",
    },
  },
}

return M
