local lualine = require('lualine')

local colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
--
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = "catppuccin",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}
--
-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- ins_left {
--   -- mode component
--   function()
--     return ''
--   end,
--   padding = { left = 1, right = 1 },
-- }

ins_left {
  'branch',
  icon = '',
  color = { fg = colors.green },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
    added = {},
    modified = {},
    removed = {},
  },
  cond = conditions.hide_in_width,
}

-- ins_left {
--   'filename',
--   cond = conditions.buffer_not_empty,
-- }

-- ins_left {'buffers'}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = { }
    -- local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      msg[#msg+1] = "N/A"
      return table.concat(msg, "")
    end
    for _, client in ipairs(clients) do
      msg[#msg+1] = client.name
    end
    return table.concat(msg, ", ")
    -- WARNING: I am unsure what this block does, and am leaving in as a comment for reference
    -- for _, client in ipairs(clients) do
    --   local filetypes = client.config.filetypes
    --   if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
    --     return client.name
    --   end
    -- end
  end,
  icon = '',
  color = { fg = colors.sapphire, gui = 'bold' },
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    error = {},
    warn = {},
    info = {},
  },
}

local function get_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then
    return ""
  end
  return schema.result[1].name
end

ins_right {
  'filetype',
  fmt = string.upper,
  icons_enabled = true,
}

ins_right { get_schema }

ins_right { 'location' }

ins_right { 'progress' }

lualine.setup(config)


local bufferline = require('bufferline')
bufferline.setup{
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
  options = {
    style_preset = bufferline.style_preset.minimal,
    enforce_regular_tabs = false,
    view = "multiwindow",
    show_buffer_close_icons = false,
    -- separator_style = "thin",
    always_show_bufferline = true,
    diagnostics = "nvim_lsp",
    themable = true,
    truncate_names = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      if context.buffer:current() then
        return ""
      end
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  },
}
