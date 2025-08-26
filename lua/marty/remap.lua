local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO: Add logic to evaluate if plugin exists?
-- keymap.set("n", "<leader>e", vim.cmd.Ex)
keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set({"n", "v"}, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("x", "<leader>p", [["_dP]])

keymap.set("n", "<leader>l", vim.cmd.Lazy)

keymap.set("n", "H", vim.cmd.bprev)
keymap.set("n", "L", vim.cmd.bnext)
keymap.set("n", "<leader>bd", vim.cmd.bdelete)

-- keymap.set("n", "<leader>ft", "<cmd>silent !tmux neww $HOME/.dotfiles/scripts/tmux-sessionizer.sh<CR>")
-- TODO: Add logic to evaluate if plugin exists?
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTelescope<CR>")
