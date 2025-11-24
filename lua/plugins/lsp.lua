return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Setup mason first
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Setup mason-lspconfig for automatic installation
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "html",
          "cssls",
          "yamlls",
          "ansiblels",
          "helm_ls",
          "terraformls",
          "bashls",
        },
        automatic_installation = true,
      })

      -- Get capabilities from nvim-cmp
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Set up LSP keybindings on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- Keybindings
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })

      -- Configure diagnostics
      local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- Configure LSP servers using vim.lsp.config
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
        capabilities = capabilities,
      })

      vim.lsp.config("html", {
        capabilities = capabilities,
      })

      vim.lsp.config("cssls", {
        capabilities = capabilities,
      })

      vim.lsp.config("yamlls", {
        filetypes = { "yaml", "yaml.ansible" },
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
              ["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
              ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
              ["https://json.schemastore.org/helmfile.json"] = "helmfile.yaml",
              kubernetes = {
                "k8s/**/*.yaml",
                "kubernetes/**/*.yaml",
                "**/manifests/**/*.yaml",
              },
            },
            validate = true,
            hover = true,
            completion = true,
          },
        },
        capabilities = capabilities,
      })

      vim.lsp.config("ansiblels", {
        filetypes = { "yaml.ansible", "ansible" },
        cmd = { "ansible-language-server", "--stdio" },
        root_markers = { "ansible.cfg", ".ansible-lint" },
        settings = {
          ansible = {
            python = {
              interpreterPath = "python3"
            },
            ansible = {
              path = "ansible"
            },
            executionEnvironment = {
              enabled = false
            },
            validation = {
              enabled = true,
              lint = {
                enabled = true,
                path = "ansible-lint"
              }
            }
          }
        },
        capabilities = capabilities,
      })

      vim.lsp.config("helm_ls", {
        filetypes = { "helm" },
        cmd = { "helm_ls", "serve" },
        root_markers = { "Chart.yaml" },
        settings = {
          ['helm-ls'] = {
            yamlls = {
              enabled = false,
              diagnosticsLimit = 50,
              showDiagnosticsDirectly = false,
              path = "yaml-language-server",
            },
            valuesFiles = {
              mainValuesFile = "values.yaml",
              lintOverlayValuesFile = "values.lint.yaml",
              additionalValuesFilesGlobs = { "values*.yaml" },
            },
          }
        },
        capabilities = capabilities,
      })

      vim.lsp.config("terraformls", {
        filetypes = { "terraform", "tf" },
        cmd = { "terraform-ls", "serve" },
        root_markers = { ".terraform", ".git" },
        capabilities = capabilities,
      })

      vim.lsp.config("bashls", {
        filetypes = { "sh", "bash" },
        cmd = { "bash-language-server", "start" },
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
          }
        },
        capabilities = capabilities,
      })

      -- Enable all LSP servers
      vim.lsp.enable({
        "lua_ls",
        "html",
        "cssls",
        "yamlls",
        "ansiblels",
        "helm_ls",
        "terraformls",
        "bashls",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
  },
}
