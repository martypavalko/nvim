vim.filetype.add({
    pattern = {
        [".*templates/.+%.yaml"] = "helm",
        [".*values%.yaml"] = "helm",
        ["Chart%.yaml"] = "helm",
    }
})

local lspconfig = require('lspconfig')
helm_ls = function ()
   require('lspconfig').helm_ls.setup({
        filetypes = { "helm" },
        cmd = { "helm_ls", "serve" },
        settings = {
            ['helm_ls'] = {
                yamlls = {
                    schemas = {
                        kubernetes = "*.yaml",
                    },
                    validate = true,
                    completion = true,
                    hover = true,
                }
            }
        },
        on_attach = function (client, bufnr)
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            print('helm_ls attached!')
        end
    })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "helm",
  callback = function()
    -- Set syntax highlighting for Helm files
    vim.bo.syntax = "yaml"
    -- Add additional syntax highlighting for Helm template expressions
    vim.cmd([[
      syn match helmTemplate "{{\s*\.[^}]*}}"
      syn match helmTemplate "{{\s*template[^}]*}}"
      hi link helmTemplate Special
    ]])
  end,
})
