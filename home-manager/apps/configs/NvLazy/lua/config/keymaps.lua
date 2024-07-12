-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<tab><leader>", ":w<CR>")
vim.keymap.set("i", "<tab><leader>", "<Esc>:w<CR>")
vim.keymap.set("i", "<tab>;", "<Esc>:w<CR>")
vim.keymap.set("n", ";", ":w<CR>")
-- vim.keymap.set("n", ";", ":")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "fg", "<Esc>la") -- vim.keymap.set("t", "<C-j>", "<C-/>")
-- float terminal keymaps
local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
-- vim.keymap.set("n", "<C-j>", lazyterm)
vim.keymap.set("n", "<tab>j", lazyterm)
vim.keymap.set("t", "<tab>j", "<cmd>close<cr>")

-- rebind format command
-- vim.keymap.set("n", "<leader>lf", "<Leader>cf")
-- formatting
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set
map({ "n", "v" }, "<leader>lf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })
