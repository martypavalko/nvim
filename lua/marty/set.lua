local opt = vim.opt

opt.guicursor = ""

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true
opt.autoindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = false

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.cursorcolumn = true
opt.isfname:append("@-@")

opt.updatetime = 50
opt.colorcolumn = "80"
opt.conceallevel = 2

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

