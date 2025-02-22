local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

nvim_lsp.ts_ls.setup({
  on_attach = function(client, bufnr)
    print("ts_ls attached!")
  end
})

nvim_lsp.svelte.setup({
  on_attach = function (client, bufnr)
    print("svelte attached!")
  end
})

nvim_lsp.tailwindcss.setup({
  on_attach = function (client, bufnr)
    print("tailwindcss attached!")
  end
})

nvim_lsp.cssls.setup({
  on_attach = function (client, bufnr)
    print("cssls attached!")
  end
})
