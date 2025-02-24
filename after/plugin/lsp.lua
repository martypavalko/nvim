local lsp = require("lsp-zero")
local mason = require("mason")
local masonLsp = require("mason-lspconfig")

lsp.preset("recommended")

local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Return>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end)

mason.setup({})
masonLsp.setup({
    ensure_installed = {
      "gopls",
      "lua_ls",
      "ansiblels",
      "bashls",
      "yamlls",
      "helm_ls",
      "terraformls",
      "pyright",
      "svelte",
      "ts_ls",
      "tailwindcss",
      "cssls",
      "omnisharp",
      "angularls"
    },
    handlers = {
        terraformls = function ()
           require('lspconfig').terraformls.setup({
                cmd = {
                    "terraform-ls", "serve"
                },
                filetypes = {
                    "terraform", "terraform-vars"
                },
                on_attach = function (client, bufnr)
                   print('terraform-ls attached!')
                end
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                },
                on_attach = function(client, bufnr)
                    print('lua_ls attached!')
                end
            })
        end,
        gopls = function()
            require('lspconfig').gopls.setup({
                on_attach = function (client, bufnr)
                   print('gopls attached!')
                end
            })
        end,
        ansiblels = function ()
           require('lspconfig').ansiblels.setup({
                filetypes = {"yaml.ansible"},
                settings = {
                    ansible = {
                        ansible = {
                            path = "ansible",
                        },
                    },
                    validation = {
                        enabled = true,
                        lint = {
                            enabled = true,
                            path = "ansible-lint",
                        },
                    },
                },
                on_attach = function (client, bufnr)
                    print('ansiblels attached!')
                end
            })
        end,
        bashls = function ()
            require('lspconfig').bashls.setup({
                filetypes = {"sh"},
                on_attach = function (client, bufnr)
                    print('bashls attached!')
                end
            })
        end,
        helm_ls = function ()
           require('lspconfig').helm_ls.setup({
                filetypes = { "helm" },
                cmd = { "helm_ls", "serve" },
                settings = {
                    ['helm_ls'] = {
                        valuesFiles = {
                            mainValuesFile = "values.yaml",
                            lintOverlayValuesFile = "values.lint.yaml",
                            additionalValuesFilesGlobPattern = "values*.yaml"
                        },
                        yamlls = {
                            schemas = {
                                kubernetes = "*.yaml",
                            },
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                            validate = true,
                            completion = true,
                            hover = true,
                        }
                    }
                },
                on_attach = function (client, bufnr)
                    print('helm_ls attached!')
                end
    })
end
    }
})

lsp.setup()

vim.diagnostic.config({
    -- virtual_text = true
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    }
  }
})

if vim.fn.expand("%:e") == "yaml"  then
    vim.keymap.set("n", "fy", ":Telescope yaml_schema<CR>")
end

