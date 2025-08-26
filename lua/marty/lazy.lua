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
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        automatic_enable = false
      },
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        },
    },
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'L3MON4D3/LuaSnip'},
    {'lewis6991/gitsigns.nvim'},
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        'echasnovski/mini.nvim', version = "*"
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
        require("nvim-tree").setup {}
        end,
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'mfussenegger/nvim-ansible'
    },
    {
        'b0o/SchemaStore.nvim'

    },
    {
        'msvechla/yaml-companion.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim'
        },
    },
    {'towolf/vim-helm'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
          init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
        end,
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function ()
            require'colorizer'.setup()
        end
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xb",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)"
            }
        },
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
        { "z", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "Z", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        }
    },
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      build = "cd app && npm install",
      init = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    },
})
