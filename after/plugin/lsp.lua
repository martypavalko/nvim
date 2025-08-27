local mason = require("mason")
local masonLsp = require("mason-lspconfig")

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
		["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
		["<Return>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},
})

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
		"angularls",
		"superhtml",
	},
})

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

if vim.fn.expand("%:e") == "yaml" then
	vim.keymap.set("n", "fy", ":Telescope yaml_schema<CR>")
end

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

nvim_lsp.terraformls.setup({
	cmd = {
		"terraform-ls",
		"serve",
	},
	filetypes = {
		"terraform",
		"terraform-vars",
	},
})

nvim_lsp.lua_ls.setup({})

nvim_lsp.gopls.setup({})

nvim_lsp.ansiblels.setup({
	filetypes = { "yaml.ansible" },
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
})

nvim_lsp.bashls.setup({
	filetypes = { "sh" },
})

nvim_lsp.superhtml.setup({})

nvim_lsp.ts_ls.setup({})

nvim_lsp.svelte.setup({})

nvim_lsp.angularls.setup({})

nvim_lsp.tailwindcss.setup({})

nvim_lsp.cssls.setup({})

nvim_lsp.omnisharp.setup({
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/Omnisharp" },
})

-- nvim_lsp.yamlls.setup({})
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

nvim_lsp.helm_ls.setup({
	filetypes = { "helm" },
	cmd = { "helm_ls", "serve" },
	settings = {
		["helm_ls"] = {
			valuesFiles = {
				mainValuesFile = "values.yaml",
				lintOverlayValuesFile = "values.lint.yaml",
				additionalValuesFilesGlobPattern = "values*.yaml",
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
			},
		},
	},
})
