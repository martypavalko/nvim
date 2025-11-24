local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Detect Ansible files
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/playbooks/*.yml",
    "*/playbooks/*.yaml",
    "*/ansible/*.yml",
    "*/ansible/*.yaml",
    "*/roles/*/tasks/*.yml",
    "*/roles/*/handlers/*.yml",
    "*/roles/*/vars/*.yml",
    "*/roles/*/defaults/*.yml",
    "*/group_vars/*",
    "*/host_vars/*",
    "site.yml",
    "playbook.yml",
    "local.yml",
  },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
  group = augroup("AnsibleFiletype", { clear = true }),
})

-- Detect Helm chart files by Chart.yaml proximity
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/templates/*.yaml",
    "*/templates/*.tpl",
    "*/templates/_*.yaml",
    "*/templates/_*.tpl",
    "*/templates/NOTES.txt",
    "Chart.yaml",
    "values*.yaml",
    "*/helm/*.yaml",
    "*/charts/*/*.yaml",
  },
  callback = function()
    local path = vim.fn.expand("%:p")
    -- Check if we're in a Helm chart (Chart.yaml exists in current or parent dirs)
    if vim.fn.findfile("Chart.yaml", vim.fn.expand("%:p:h") .. ";") ~= "" then
      vim.bo.filetype = "helm"
    end
  end,
  group = augroup("HelmFiletype", { clear = true }),
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  group = augroup("HighlightYank", { clear = true }),
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  group = augroup("TrimWhitespace", { clear = true }),
})

-- Auto close nvim-tree when it's the last window
autocmd("BufEnter", {
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.bo.filetype == "NvimTree" then
      vim.cmd("quit")
    end
  end,
  group = augroup("NvimTreeAutoClose", { clear = true }),
})

-- Remember cursor position
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  group = augroup("RememberCursor", { clear = true }),
})

-- Handle opening a directory - show dashboard and open nvim-tree
autocmd("VimEnter", {
  callback = function(data)
    -- Check if the argument is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
      return
    end

    vim.cmd.cd(data.file)
    -- Delete the directory buffer
    vim.cmd.bwipeout(data.buf)

    -- Schedule opening nvim-tree after dashboard loads
    -- vim.schedule(function()
    --   require("nvim-tree.api").tree.open()
    -- end)
  end,
  group = augroup("NvimTreeOpenDir", { clear = true }),
})
