require('lualine').setup {
    options = {
    --     section_separators = '', component_separators = ''
        section_separators = '', component_separators = ''
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'buffers'},
        lualine_x = {'filesize', 'filetype'},
        -- lualine_y = {'progress'},
        lualine_y = {'selectioncount'},
        lualine_z = {'location'}
    }
}
