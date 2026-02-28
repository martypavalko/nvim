return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
    keys = {
      { "<leader>db", function() require("easy-dotnet").build() end,           desc = "Dotnet Build" },
      { "<leader>dr", function() require("easy-dotnet").run() end,             desc = "Dotnet Run" },
      { "<leader>dt", function() require("easy-dotnet").test() end,            desc = "Dotnet Test" },
      { "<leader>dp", function() require("easy-dotnet").add_package() end,     desc = "Dotnet Add Package" },
      { "<leader>ds", function() require("easy-dotnet").solution_select() end, desc = "Dotnet Solution Select" },
      { "<leader>dn", function() require("easy-dotnet").new() end,             desc = "Dotnet New" },
    },
    config = function()
      require("easy-dotnet").setup({
        lsp = {
          config = {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            settings = {
              ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_parameters = true,
              },
              ["csharp|completion"] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
              },
            },
          },
        },
      })

      -- Fix: Telescope picker from LSP root_dir loses focus to the code buffer.
      -- Wrap the picker to refocus the Telescope prompt window after it opens.
      local telescope_picker = require("easy-dotnet.picker._telescope")
      local original_picker = telescope_picker.picker
      telescope_picker.picker = function(bufnr, options, on_select_cb, title, autopick, apply_numeration)
        original_picker(bufnr, options, on_select_cb, title, autopick, apply_numeration)
        vim.defer_fn(function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].filetype == "TelescopePrompt" then
              vim.api.nvim_set_current_win(win)
              vim.cmd("startinsert")
              return
            end
          end
        end, 100)
      end
    end,
  },
}
