return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ft = "markdown",
    ---@module 'obsidian'
    opts = {
      -- Use the title as-is for the filename (no auto-generated ID)
      note_id_func = function(title)
        return title
      end,
      frontmatter = {
        enabled = false
      },
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      legacy_commands = false,
      workspaces = {
        {
          name = "PKM",
          path = "~/Documents/PKM/",
        },
      },
    },
  }
}
