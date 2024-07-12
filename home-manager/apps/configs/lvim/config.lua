-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- Save current buffer with <Tab><Leader>
lvim.keys.normal_mode["<Tab><Leader>"] = ":w<CR>"
lvim.keys.insert_mode["<Tab><Leader>"] = "<Esc>:w<CR>"

-- Save current buffer with <Tab>; in insert mode
lvim.keys.insert_mode["<Tab>;"] = "<Esc>:w<CR>"

-- Save current buffer with ; in normal mode
lvim.keys.normal_mode[";"] = ":w<CR>"

-- Map jj to escape in insert mode
lvim.keys.insert_mode["jj"] = "<Esc>"

-- Map fg to exit insert mode and move to end of line and start insert
lvim.keys.insert_mode["fg"] = "<Esc>la"

-- Open a lazyterm session with <Tab>j in normal mode and terminal mode
lvim.keys.normal_mode["<Tab>j"] = "<cmd>ToggleTerm<cr>"
-- lvim.keys.term_mode["<Tab>j"] = "<cmd>close<cr>"
lvim.keys.term_mode["<Tab>j"] = "<cmd>ToggleTerm<cr>"
-- lvim.keys.tree_mode["<Tab>j"] = "<cmd>ToggleTerm<cr>"

-- buffers
lvim.keys.normal_mode["<Leader>bo"] = ":BufferLineCloseOthers<CR>"
lvim.keys.normal_mode["<Leader>bd"] = ":BufferKill<CR>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- lsp
-- lvim.keys.normal_mode["<Leader>gd"] = "<cmd>lua vim.lsp.buf.definition()<cr>"



-- KEYS:
-- gl - open diagnostic text in float window
