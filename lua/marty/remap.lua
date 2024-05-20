local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "<leader>e", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("x", "<leader>p", [["_dP]])
