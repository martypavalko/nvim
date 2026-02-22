return {
  {
    "seblj/roslyn.nvim",
    ft = "cs",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    opts = {
      config = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          ["csharp|inlay_hints"] = {
            ["csharp_enable_inlay_hints_for_types"] = true,
            ["dotnet_enable_inlay_hints_for_parameters"] = true,
          },
          ["csharp|completion"] = {
            ["dotnet_show_completion_items_from_unimported_namespaces"] = true,
          },
        },
      },
    },
  },
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
    },
    config = function()
      require("easy-dotnet").setup()
    end,
  },
}
