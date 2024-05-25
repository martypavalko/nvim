require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    }
})

function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Colors:
-- catppuccin
-- eldritch

ColorMyPencils()
