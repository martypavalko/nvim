local cfg = require("yaml-companion").setup {
  -- detect k8s schemas based on file content
  builtin_matchers = {
    kubernetes = { enabled = true }
  },

  -- schemas available in Telescope picker
  schemas = {
    -- not loaded automatically, manually select with
    -- :Telescope yaml_schema
    {
      name = "Argo CD Application",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
    },
    {
      name = "SealedSecret",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"
    },
    {
      name = "ExternalSecret",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/external-secrets.io/externalsecret_v1beta1.json"
    },
    {
      name = "SecretStore",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/external-secrets.io/secretstore_v1beta1.json"
    },
    {
      name = "ClusterSecretStore",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/external-secrets.io/clustersecretstore_v1beta1.json"
    },
    {
      name = "ClusterExternalSecret",
      uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/external-secrets.io/clusterexternalsecret_v1beta1.json"
    },
    -- schemas below are automatically loaded, but added
    -- them here so that they show up in the statusline
    {
      name = "Kustomization",
      uri = "https://json.schemastore.org/kustomization.json"
    },
    {
      name = "GitHub Workflow",
      uri = "https://json.schemastore.org/github-workflow.json"
    },
  },

  lspconfig = {
    settings = {
      yaml = {
        validate = true,
        schemaStore = {
          enable = false,
          url = ""
        },

        -- schemas from store, matched by filename
        -- loaded automatically
        schemas = require('schemastore').yaml.schemas {
          select = {
            'kustomization.yaml',
            'GitHub Workflow',
          }
        }
      }
    }
  }
}

require("lspconfig")["yamlls"].setup(cfg)

require("telescope").load_extension("yaml_schema")

-- get schema for current buffer
local function get_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then
    return ""
  end
  return schema.result[1].name
end

require('lualine').setup {
  sections = {
    lualine_x = {'fileformat', 'filetype', get_schema}
  }
}

vim.filetype.add({
    pattern = {
        [".*templates/.+%.yaml"] = "helm",
        [".*values%.yaml"] = "helm",
        ["Chart%.yaml"] = "helm",
    }
})

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
