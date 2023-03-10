-- keymaps

local options = { noremap = true, silent = true }
local silent = { silent = true }

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Shortcut to use blackhole register by default
-- vim.keymap.set("v", "d", '"_d', options)
-- vim.keymap.set("v", "D", '"_D', options)
-- vim.keymap.set("v", "c", '"_c', options)
-- vim.keymap.set("v", "C", '"_C', options)
-- vim.keymap.set("v", "x", '"_x', options)
-- vim.keymap.set("v", "X", '"_X', options)
-- vim.keymap.set("n", "d", '"_d', options)
-- vim.keymap.set("n", "D", '"_D', options)
-- vim.keymap.set("n", "c", '"_c', options)
-- vim.keymap.set("n", "C", '"_C', options)
-- vim.keymap.set("n", "x", '"_x', options)
-- vim.keymap.set("n", "X", '"_X', options)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Use ctlr + hjkl to resize windows:
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
vim.keymap.set("n", "<C-d>", "<C-d>zz", silent)
vim.keymap.set("n", "<C-u>", "<C-u>zz", silent)

-- buffers
vim.keymap.set("n", "<M-}>", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<M-{>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-S-]>", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-S-[>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-Left>", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-Right>", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>qq", "<CMD>q<CR>", { desc = "[Q]uit" })

-- files
vim.keymap.set("n", "<leader>eb", "<CMD>e ~/apps/vimwiki/cookbook/cookbook.md<CR>", { desc = "[E]dit Cook[b]ook" })
vim.keymap.set("n", "<leader>ew", "<CMD>e ~/apps/vimwiki/index.md<CR>", { desc = "[E]dit Vim[W]iki" })
vim.keymap.set("n", "<leader>ez", "<CMD>e ~/.config/zsh/.zshrc<CR>", { desc = "[E]dit [Z]shrc" })
vim.keymap.set("n", "<leader>ex", "<CMD>e ~/.Xresources<CR>", { desc = "[E]dit [X]resources" })
vim.keymap.set("n", "<leader>es", "<CMD>e ~/.config/sxhkd/sxhkdrc<CR>", { desc = "[E]dit [S]xhkdrc" })

-- disable the arrow keys
--[[ vim.keymap.set({ "i", "n" }, "<Up>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Down>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Left>", "<NOP>")
vim.keymap.set({ "i", "n" }, "<Right>", "<NOP>") ]]

-- quickfix
vim.keymap.set("n", "<leader>qc", "<CMD>cclose<CR>", { desc = "[Q]uickfix [C]lose" })
vim.keymap.set("n", "<leader>qo", "<CMD>copen<CR>", { desc = "[Q]uickfix [O]pen" })
vim.keymap.set("n", "<leader>qg", "<CMD>cfirst<CR>", { desc = "[Q]uickfix First" })
vim.keymap.set("n", "<leader>qG", "<CMD>clast<CR>", { desc = "[Q]uickfix Last" })

-- personal
vim.keymap.set("n", "<leader>mt", function()
  require("me.config.utils").ToggleHiddenAll()
end, { desc = "[T]oggle All" })
vim.keymap.set("n", "<leader>bd", "<CMD>bd<CR>", { desc = "[D]elete [B]uffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>%bd|e#<cr>", { desc = "Close all buffers but the current one" }) -- https://stackoverflow.com/a/42071865/516188
