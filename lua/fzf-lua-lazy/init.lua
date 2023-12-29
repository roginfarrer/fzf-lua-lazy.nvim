local M = {}

M.defaults = {
  mappings = {
    open_readme = 'default',
    open_in_browser = 'ctrl-o',
    open_in_find_files = 'ctrl-f',
    open_in_live_grep = 'ctrl-g',
    open_lazy_root_find_files = 'ctrl-alt-f',
    open_lazy_root_live_grep = 'ctrl-alt-g',
    change_cwd_to_plugin = 'ctrl-alt-d',
  },
}

M.opts = M.defaults

function M.setup(user_opts)
  user_opts = user_opts or {}
  M.opts = vim.tbl_deep_extend('force', M.defaults, user_opts)
end

M.search = require('fzf-lua-lazy.search').lazy

return M
