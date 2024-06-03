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
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lsp' },
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
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

mason.setup({})
masonLsp.setup({
    ensure_installed = { "gopls", "lua_ls", "ansiblels", "bashls", "yamlls" },
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
        -- yamlls = function ()
        --     require('lspconfig').yamlls.setup({
        --         on_attach = function (client, bufnr)
        --             print('yamlls attached!')
        --         end
        --     })
        -- end,
        -- yamlls = function ()
        --     require('lspconfig').yamlls.setup({
        --         settings = {
        --             yaml = {
        --                 schemaStore = {
        --                     enable = false,
        --                     url = ""
        --                 },
        --                 schemas = {
        --                     -- kubernetes = "globPattern",
        --                     Kubernetes = "*.yaml",
        --                     -- ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        --                     -- ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
        --                     -- ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        --                     -- ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        --                     -- ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        --                     -- ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        --                     -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        --                     -- ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
        --                 },
        --                 format = { enabled = false },
        --                 validate = true,
        --                 completion = true,
        --                 hover = true,
        --             },
        --         },
        --         on_attach = function (client, bufnr)
        --             print('yamlls attached!')
        --         end
        --     })
        -- end,
    }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
