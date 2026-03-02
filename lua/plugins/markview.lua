return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("markview").setup({
      markdown = {
        preview = {
          icon_provider = "devicons",
        },
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown" },
      callback = function()
        vim.keymap.set("n", "<leader>mt", "<cmd>Markview Toggle<cr>", { desc = "Toggle Markview" })
        vim.keymap.set("n", "<leader>ms", "<cmd>Markview splitToggle<cr>", { desc = "Toggle Markview Split View" })
      end,
    })
  end,
}
