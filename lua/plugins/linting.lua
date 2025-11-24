return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Define kube-linter since it's not built into nvim-lint
      lint.linters.kube_linter = {
        cmd = "kube-linter",
        stdin = false,
        args = { "lint", "--format=json" },
        stream = "stdout",
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded or not decoded.Reports then
            return diagnostics
          end

          for _, report in ipairs(decoded.Reports) do
            table.insert(diagnostics, {
              lnum = 0,
              col = 0,
              message = report.Check .. ": " .. report.Message,
              severity = vim.diagnostic.severity.WARN,
              source = "kube-linter",
            })
          end

          return diagnostics
        end,
      }

      -- Configure linters by filetype
      lint.linters_by_ft = {
        yaml = { "yamllint" },
        helm = { "kube_linter" },
      }

      -- Auto-lint on save
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
