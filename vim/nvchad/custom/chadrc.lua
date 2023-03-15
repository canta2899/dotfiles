local M = {}

M.ui = {
  theme = "onedark",
  transparency = false,

  nvdash = {
      load_on_startup = false,

      header = {
        "                            _              ",
        "                           (_)             ",
        "      ____   ____ ___ _   _ _ ____         ",
        "     |  _ \\ / _  ) _ \\ | | | |    \\     ",
        "     | | | ( (/ / |_| \\ V /| | | | |      ",
        "     |_| |_|\\____)___/ \\_/ |_|_|_|_|     ",
      },

      buttons = {
        { "  Find File", "Spc f f", "Telescope find_files" },
        { "  Recent Files", "Spc f o", "Telescope oldfiles" },
        { "  Find Word", "Spc f w", "Telescope live_grep" },
        { "  Bookmarks", "Spc b m", "Telescope marks" },
        { "  Themes", "Spc t h", "Telescope themes" },
        { "  Mappings", "Spc c h", "NvCheatsheet" },
      },
    },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"


return M
