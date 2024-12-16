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

-- Terminal: on Tab-j open as float, on default C-/ - open at bottom
vim.keymap.set("n", "<Tab>j", function()
  Snacks.terminal(nil, { 
    cwd = LazyVim.root(),
    win = { 
      relative = "editor",
      position = "float",
      width = 0.8,
      height = 0.8,
      border = "rounded",
    }
  })
end, { desc = "Terminal (Root Dir)" })  -- Normal mode
vim.keymap.set("t", "<Tab>j", "<cmd>close<cr>", { desc = "Hide Terminal" })  -- Terminal mode
--
-- vim.keymap.set("n", "<c-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root(), win = { style = "terminal" }}) end, { desc = "Terminal (Root Dir)" })  -- Normal mode

