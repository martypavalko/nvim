local lsp = require("lsp-zero")
local mason = require("mason")
local masonLsp = require("mason-lspconfig")

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
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
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    }
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

mason.setup({})
masonLsp.setup({
    ensure_installed = { "gopls", "lua_ls", "ansiblels", "bashls", "yamlls", "helm_ls"},
    handlers = {
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
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
