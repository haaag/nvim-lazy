-- [[ keymaps ]]

local options = { noremap = true, silent = true }
local silent = { silent = true }

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Shortcut to use blackhole register by default
vim.keymap.set("v", "d", '"_d', options)
vim.keymap.set("v", "D", '"_D', options)
vim.keymap.set("v", "c", '"_c', options)
vim.keymap.set("v", "C", '"_C', options)
vim.keymap.set("v", "x", '"_x', options)
vim.keymap.set("v", "X", '"_X', options)
vim.keymap.set("n", "d", '"_d', options)
vim.keymap.set("n", "D", '"_D', options)
vim.keymap.set("n", "c", '"_c', options)
vim.keymap.set("n", "C", '"_C', options)
vim.keymap.set("n", "x", '"_x', options)
vim.keymap.set("n", "X", '"_X', options)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use alt + hjkl to resize windows:
vim.keymap.set("n", "<C-j>", ":resize -2<CR>", options)
vim.keymap.set("n", "<C-k>", ":resize +2<CR>", options)
vim.keymap.set("n", "<C-l>", ":vertical resize -2<CR>", options)
vim.keymap.set("n", "<C-h>", ":vertical resize +2<CR>", options)

-- Keep search results centred
vim.keymap.set("n", "n", "nzzzv", silent)
vim.keymap.set("n", "N", "Nzzzv", silent)

-- Make Y yank to end of the line
vim.keymap.set("n", "Y", "y$", silent)

-- Move lines
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", {})
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", {})

-- C-d 'n C-u centred
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})

-- buffers
vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Buffer close" })
vim.keymap.set("n", "<M-}>", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<M-{>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })

-- file explorer
vim.keymap.set("n", "<F3>", "<CMD>silent Lexplore %:p:h<CR>", { desc = "File explorer vsplit" })
vim.keymap.set("n", "<leader><F3>", "<CMD>silent Lexplore<CR>", { desc = "File explorer vsplit" })

-- files
vim.keymap.set("n", "<leader>sb", "<CMD>e ~/apps/vimwiki/cookbook/cookbook.md<CR>", { desc = "Cookbook" })
vim.keymap.set("n", "<leader>sv", "<CMD>e ~/apps/vimwiki/index.md<CR>", { desc = "VimWiki" })
vim.keymap.set("n", "<leader>sn", "<CMD>e ~/.config/nvim/lua/me/plugins/init.lua<CR>", { desc = "Nvim plugins" })
vim.keymap.set("n", "<leader>sz", "<CMD>e ~/.config/zsh/.zshrc<CR>", { desc = "Zshrc" })
vim.keymap.set("n", "<leader>sx", "<CMD>e ~/.Xresources<CR>", { desc = "Xresources" })
vim.keymap.set("n", "<leader>ss", "<CMD>e ~/.config/sxhkd/sxhkdrc<CR>", { desc = "Xresources" })

-- disable the arrow keys
vim.keymap.set({ "i", "n" }, "<Up>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Down>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Left>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Right>", "<NOP>")