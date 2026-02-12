return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "html",
          "css",
          "bash",
          "yaml",
          "terraform",
          "hcl",
          "markdown",
          "markdown_inline",
          "c_sharp",
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        indent = {
          enable = true,
        },
        auto_install = true,
      })
    end,
  },
}
