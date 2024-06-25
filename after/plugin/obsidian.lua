local keymap = vim.keymap

keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>")
keymap.set("n", "<leader>oo", "<cmd>ObsidianFollowLink<CR>")

require("obsidian").setup({
    workspaces = {
        {
            name = "PKM",
            path = "~/PKM/",
        },
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2
    },
    notes_subdir = "000 Library/001 Fleeting Notes/",
    new_notes_location = "notes_subdir",

})
