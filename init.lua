-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw at the very start (before plugins load)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})

-- Load core configurations
require("core.options")
require("core.keymaps")
require("core.autocmds")
