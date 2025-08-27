require("nvim-tree").setup({
	view = {
		width = 35,
		side = "right",
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
})
