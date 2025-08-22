local status_ok = pcall(require, "lspconfig")
if not status_ok then
  return
end

local masonLsp = require("mason-lspconfig")

masonLsp.setup({
  handlers = {
    pyright = function ()
      require('lspconfig').pyright.setup({

        on_attach = function(client, bufnr)

          if vim.bo.filetype ~= 'python' then
            return
          end

        end,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              extraPaths = { "." },  -- Add your Django project root if needed
            },
          },
        },
      })
    end
  }
})
