return {
  {
    name = "colorscheme",
    dir = vim.fn.stdpath("config"),
    dependencies = { "catppuccin", "kanagawa" },
    priority = 999,
    config = function()
      -- vim.cmd.colorscheme("tokyonight-night")
      vim.cmd.colorscheme("catppuccin")
      -- vim.cmd("colorscheme kanagawa-wave")
      vim.keymap.set("n", "<leader>tt", function()
        local cat = require("catppuccin")
        cat.options.transparent_background = not cat.options.transparent_background
        cat.compile()
        vim.cmd.colorscheme(vim.g.colors_name)
      end, { desc = "Toggle catppuccin's background transparency" })
    end,
  },
}
