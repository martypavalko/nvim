return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal<cr>",
        desc = "Find buffers",
      },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Find old files" },
      {
        "<leader>fz",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Find in current buffer",
      },
      { "<leader>fgc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>fgs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>ft", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find LSP Document Symbols" },
      { "<leader>fs", "<cmd>Telescope lsp_references<cr>", desc = "Find LSP References" },
      {
        "<leader>fd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Buffer Diagnostics",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local open_with_trouble = require("trouble.sources.telescope").open

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
              ["<C-n>"] = actions.move_selection_next,
              ["<C-p>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
              ["<C-t>"] = open_with_trouble,
            },
            n = {
              ["q"] = actions.close,
              ["d"] = actions.delete_buffer,
              ["<C-t>"] = open_with_trouble,
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
