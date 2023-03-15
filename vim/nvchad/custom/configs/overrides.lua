-- overrides defult plugin configs

local lsplanguages = require "custom.configs.lsplanguages"

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
    "ocaml",
    "haskell"
	},
}

M.mason = {
  ensure_installed = getmasonlist()
}

return M
