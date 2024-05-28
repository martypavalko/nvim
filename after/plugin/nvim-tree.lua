require("nvim-tree").setup({
  view = {
    width = 45,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
