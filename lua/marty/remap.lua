local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- keymap.set("n", "<leader>e", vim.cmd.Ex)
keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("x", "<leader>p", [["_dP]])

keymap.set("n", "<leader>l", vim.cmd.Lazy)

keymap.set("n", "<leader>bh", vim.cmd.bprev)
keymap.set("n", "<leader>bl", vim.cmd.bnext)
keymap.set("n", "<leader>bq", vim.cmd.bdelete)
