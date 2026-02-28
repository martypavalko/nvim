return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "FormatDisable", "FormatEnable" },
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
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
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
