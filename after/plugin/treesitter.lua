require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "lua",
    "go",
    "gowork",
    "gomod",
    "gosum",
    "gotmpl",
    "sql",
    "json",
    "comment",
    "python",
    "vim",
    "vimdoc",
    "typescript",
    "javascript",
    "svelte",
    "css",
    "html",
    "angular"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true
  },
}

local parsers = require "nvim-treesitter.parsers"

local parser_config = parsers.get_parser_configs()
parser_config.jsonc.filetype_to_parsername = "json"
