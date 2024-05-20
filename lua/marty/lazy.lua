local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "python", "go", "lua", "vim", "vimdoc" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            })
        end
    },
    {
        "eldritch-theme/eldritch.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'echasnovski/mini.nvim', version = false
    },
})
