return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        float = {
          transparent = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          mason = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
      vim.keymap.set("n", "<leader>tt", function()
        local cat = require("catppuccin")
        cat.options.transparent_background = not cat.options.transparent_background
        cat.compile()
        vim.cmd.colorscheme(vim.g.colors_name)
      end, { desc = "Toggle catppuccin's background transparency" })
    end,
  },
}
