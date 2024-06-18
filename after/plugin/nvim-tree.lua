require("nvim-tree").setup({
  view = {
    width = 45,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})
