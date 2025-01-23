vim.filetype.add({
    pattern = {
        [".*templates/.+%.yaml"] = "helm",
        [".*values%.yaml"] = "helm",
        ["Chart%.yaml"] = "helm",
    }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "helm",
  callback = function()
    -- Set syntax highlighting for Helm files
    vim.bo.syntax = "yaml"
    -- Add additional syntax highlighting for Helm template expressions
    vim.cmd([[
      syn match helmTemplate "{{\s*\.[^}]*}}"
      syn match helmTemplate "{{\s*template[^}]*}}"
      hi link helmTemplate Special
    ]])
  end,
})
