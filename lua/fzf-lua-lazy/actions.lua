local builtin = require 'fzf-lua'
local plugins = require('fzf-lua-lazy.lazy-plugins').plugins
local lazy_options = require('lazy.core.config').options

local function getPluginProperty(selected, property)
  local result
  for _, plugin in ipairs(plugins) do
    if plugin.name == selected[1] then
      result = plugin[property]
    end
  end
  return result
end

local M = {}

M.open_readme = function(selected)
  local readme = getPluginProperty(selected, 'readme')
  local command = string.format('edit %s', readme)
  vim.cmd(command)
end

M.open_in_browser = function(selected)
  local open_cmd
  if vim.fn.executable 'xdg-open' == 1 then
    open_cmd = 'xdg-open'
  elseif vim.fn.executable 'explorer' == 1 then
    open_cmd = 'explorer'
  elseif vim.fn.executable 'open' == 1 then
    open_cmd = 'open'
  elseif vim.fn.executable 'wslview' == 1 then
    open_cmd = 'wslview'
  end

  if not open_cmd then
    vim.notify(
      'Open in browser is not supported by your operating system.',
      vim.log.levels.ERROR,
      { title = 'FzfLua Lazy' }
    )
  else
    local url = getPluginProperty(selected, 'url')
    local ret = vim.fn.jobstart({ open_cmd, url }, { detach = true })
    if ret <= 0 then
      vim.notify(
        string.format("Failed to open '%s'\nwith command: '%s' (ret: '%d')", url, open_cmd, ret),
        vim.log.levels.ERROR,
        { title = 'FzfLua Lazy' }
      )
    end
  end
end

M.open_in_find_files = function(selected)
  local path = getPluginProperty(selected, 'path')
  builtin.files { cwd = path }
end

M.open_in_live_grep = function(selected)
  local path = getPluginProperty(selected, 'path')
  builtin.live_grep { cwd = path }
end

M.change_cwd_to_plugin = function(selected)
  local path = getPluginProperty(selected, 'path')
  if vim.fn.getcwd() == path then
    return
  end
  local ok, res = pcall(vim.cmd.cd, path)
  if ok then
    vim.notify(string.format("Changed cwd to: '%s'.", path), vim.log.levels.INFO, { title = 'FzfLua Lazy' })
  else
    vim.notify(
      string.format("Could not change cwd to: '%s'.\nError: '%s'" .. path, res),
      vim.log.levels.ERROR,
      { title = 'FzfLua Lazy' }
    )
  end
end

function M.open_lazy_root_find_files()
  builtin.files { cwd = lazy_options.root }
end

function M.open_lazy_root_live_grep()
  builtin.live_grep { cwd = lazy_options.root }
end

M.setup_mappings = function()
  local tbl = {}
  local mappings = require('fzf-lua-lazy').opts.mappings
  for action_name, mapping in pairs(mappings) do
    tbl[mapping] = M[action_name]
  end
  return tbl
end

return M
