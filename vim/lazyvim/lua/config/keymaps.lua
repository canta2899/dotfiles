-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-n>", function()
  Snacks.explorer()
end, { desc = "Toggle Explorer" })

-- Flash jump on C-s (overrides LazyVim's default C-s save)
vim.keymap.set({ "n", "x", "o" }, "<C-s>", function()
  require("flash").jump()
end, { desc = "Flash Jump" })

-- Restore 's' to default neovim substitute (flash.nvim remaps it by default)
pcall(vim.keymap.del, "n", "s")
pcall(vim.keymap.del, "x", "s")
pcall(vim.keymap.del, "o", "s")

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
