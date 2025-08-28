require("catppuccin").setup({
	flavour = "macchiato",
	default_integrations = false,
	integrations = {
		cmp = true,
		flash = true,
		-- gitsigns = true,
		gitsigns = {
			enabled = true,
			transparent = false,
		},
		harpoon = true,
		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
		}),
		mini = {
			enabled = true,
			independent_color = "",
		},
		nvimtree = true,
		telescope = {
			enabled = true,
		},
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
				ok = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
				ok = { "underline" },
			},
			inlay_hints = {
				background = true,
			},
		},
	},
})

function ColorMyPencils(color)
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils("catppuccin")
