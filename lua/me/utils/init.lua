---@class me.utils: Core
---@field toggle me.utils.toggle
---@field lsp me.utils.lsp
---@field diagnostic me.utils.lsp
---@field icons me.utils.icons
---@field colors me.utils.colors
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require('me.utils.' .. k)
    return t[k]
  end,
})

M.highlight = setmetatable({}, {
  __newindex = function(_, hlgroup, args)
    local guifg, guibg, gui, guisp = args.guifg, args.guibg, args.gui, args.guisp
    local cmd = { 'hi', hlgroup }
    if guifg then
      table.insert(cmd, 'guifg=' .. guifg)
    end
    if guibg then
      table.insert(cmd, 'guibg=' .. guibg)
    end
    if gui then
      table.insert(cmd, 'gui=' .. gui)
    end
    if guisp then
      table.insert(cmd, 'guisp=' .. guisp)
    end
    vim.cmd(table.concat(cmd, ' '))
  end,
})

---@param mesg string
---@param choices string[]
function M.confirm(mesg, choices)
  local valid_choices = {}

  for _, choice in ipairs(choices) do
    valid_choices[choice:lower()] = true
  end

  local choice = vim.fn.input(mesg)
  choice = choice:lower()

  if valid_choices[choice] then
    return true
  else
    return false
  end
end

---@param mesg string
---@return string
function M.input(mesg)
  local choice = vim.fn.input(mesg)
  choice = choice:lower()
  return choice
end

function M.set_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local root_patterns = { '.git', 'Makefile', 'lua' }
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

function M.get_root()
  -- Array of file names indicating root directory. Modify to your liking.
  local root_patterns = { '.git', 'Makefile', 'lua' }

  -- Cache to use for speed up (at cost of possibly outdated results)
  local root_cache = {}

  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    return
  end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_patterns, { path = path, upward = true })[1]
    if root_file == nil then
      return
    end
    root = vim.fs.dirname(root_file)
    root_cache[path] = root
  end

  -- Set current directory
  vim.fn.chdir(root)
end

function M.find_files()
  local builtin
  local theme = require('telescope.themes')
  if vim.loop.fs_stat(vim.loop.cwd() .. '/.git') then
    builtin = 'git_files'
  else
    builtin = 'find_files'
  end
  require('telescope.builtin')[builtin](theme.get_ivy())
end

function M.contains(array, target)
  for _, value in ipairs(array) do
    if value == target then
      return true
    end
  end
  return false
end

---@param value string
---@return boolean
function M.boolme(value)
  local falseish = { 'false', 'no', 'n', '0', 0, false, nil, 'nil' }
  if M.contains(falseish, value) then
    return false
  end

  return true
end

---@param name string
function M.augroup(name)
  return vim.api.nvim_create_augroup('me_' .. name, { clear = true })
end

return M