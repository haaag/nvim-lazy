-- lualine.lua
-- https://github.com/nvim-lualine/lualine.nvim

local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  enabled = true,
}

M.config = function()
  local colors = require("me.config.colors").current()

  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand("%:p:h")
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  -- Config
  local config = {
    options = {
      -- Disable sections and component separators
      component_separators = "",
      section_separators = "",
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
      },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
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

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left({
    function()
      -- return "┃"
      return " "
    end,
    color = { fg = colors.blue }, -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
  })

  ins_left({
    -- mode component
    function()
      -- return ''
      -- return "●"
      return ""
    end,
    color = function()
      -- auto change color according to neovims mode
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [""] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [""] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red,
      }
      return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
  })

  ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.blue, gui = "bold" },
  })

  ins_left({
    "branch",
    icon = "",
    -- color = { fg = colors.red, gui = "bold" },
    color = { fg = colors.red },
  })

  ins_left({
    "diff",
    -- symbols = { added = " ", modified = "柳", removed = " " },
    symbols = { added = "+", modified = "~", removed = "-" },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
  })

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left({
    function()
      return "%="
    end,
  })

  ins_right({ -- lsp server
    function()
      local clients = {}
      local msg = "No Active Lsp"
      if next(vim.lsp.get_active_clients()) == nil then
        return msg
      end
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        clients[#clients + 1] = client.name
      end
      return table.concat(clients, ",")
    end,
    icon = "",
    color = { fg = colors.cyan },
  })

  ins_right({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " " },
    diagnostics_color = {
      color_error = { fg = colors.red },
      color_warn = { fg = colors.yellow },
      color_info = { fg = colors.cyan },
    },
  })

  ins_right({ "location" })

  ins_right({ "progress", color = { fg = colors.red, gui = "bold" } })

  ins_right({
    function()
      -- return "┃"
      return " "
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
  })

  -- Now don't forget to initialize lualine
  require("lualine").setup(config)
end

return M