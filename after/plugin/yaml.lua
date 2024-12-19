local lspconfig = require('lspconfig')

lspconfig.yamlls.setup({
    settings = {
        yaml = {
            schemas = {
                -- kubernetes = "/*.yaml",
                -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0/all.json"] = "/*.yaml",
                -- ["https://json.schemastore.org/kubernetes.json"] = {
                --   "/*.yaml",
                --   "/*.k8s.yaml",
                --   "/*.kubernetes.yaml",
                --   "/k8s/*.yaml"
                -- },
                ["https://json.schemastore.org/traefik-v2.json"] = {
                  "**/traefik/**/*.yaml",
                  "**/ingressroute*.yaml",
                  "**/middleware*.yaml",
                  "**/*traefik*.yaml"
                },
            },
        },
    },
})
