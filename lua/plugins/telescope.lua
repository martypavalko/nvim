return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",                                        desc = "Find files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>",                                         desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",                                           desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",                                         desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                                          desc = "Find old files" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                         desc = "Find in current buffer" },
      { "<leader>cm", "<cmd>Telescope git_commits<cr>",                                       desc = "Git commits" },
      { "<leader>gt", "<cmd>Telescope git_status<cr>",                                        desc = "Git status" },
      { "<leader>ma", "<cmd>Telescope marks<cr>",                                             desc = "Telescope bookmarks" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { "^.git/" },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<Esc>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/" },
          },
        },
      })
    end,
  },
}
