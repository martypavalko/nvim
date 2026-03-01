local keymap = vim.keymap

-- General keymaps
keymap.set("n", ";", ":", { desc = "Enter command mode" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer navigation
keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<C-x>", "<cmd>bp|bd! #<CR>", { desc = "Close buffer" })

-- Move lines in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep visual selection when indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Better paste
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- System clipboard (use <leader>y to copy TO system, <leader>p to paste FROM system)
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from system clipboard (before)" })

-- Clear search highlighting
keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- NvimTree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Kubernetes/Helm commands
keymap.set("n", "<leader>kv", "<cmd>!kubeconform -summary -strict %<cr>", { desc = "Kubeconform validate file" })
keymap.set(
  "n",
  "<leader>kc",
  "<cmd>!kubeconform -summary -strict -schema-location default -schema-location 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/{{.Group}}/{{.ResourceKind}}_{{.ResourceAPIVersion}}.json' %<cr>",
  { desc = "Kubeconform validate with CRDs" }
)

-- Better navigation
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result centered" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result centered" })

local function toggleConcealLevel()
  vim.opt.conceallevel = (vim.opt.conceallevel:get() + 1) % 3
  print("set conceallevel=" .. vim.opt.conceallevel:get())
end

keymap.set("n", "<leader>v", toggleConcealLevel, { desc = "Switches the conceallevel between 0 to 2" })

keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
end)

-- Remap 'exit terminal-mode'
vim.cmd("tnoremap <Esc><Esc> <C-\\><C-n>")
