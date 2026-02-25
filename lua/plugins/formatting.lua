return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup({
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          terraform = { "terraform_fmt" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          go = { "goimports", "gofmt" },
          cs = { "csharpier" },
          python = { "isort", "black" },
          nginx = { "nginx_config_formatter" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })

      local tools = { "stylua", "shfmt", "goimports", "csharpier", "isort", "black", "nginx_config_formatter" }
      local registry = require("mason-registry")
      registry.refresh(function()
        for _, tool in ipairs(tools) do
          local ok, pkg = pcall(registry.get_package, tool)
          if ok and not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
}
