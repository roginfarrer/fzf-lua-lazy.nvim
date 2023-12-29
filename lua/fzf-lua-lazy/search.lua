local M = {}

local plugins = require("fzf-lua-lazy.lazy-plugins").plugins

local function setupPreview()
	local previewer = require("fzf-lua.previewer.builtin")
	local path = require("fzf-lua.path")

	-- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
	-- Can this be any simpler? Do I need a custom previewer?
	local MyPreviewer = previewer.buffer_or_file:extend()

	function MyPreviewer:new(o, op, fzf_win)
		MyPreviewer.super.new(self, o, op, fzf_win)
		setmetatable(self, MyPreviewer)
		return self
	end

	function MyPreviewer:parse_entry(entry_str)
		local readme
		for _, plugin in ipairs(plugins) do
			if entry_str == plugin.name then
				readme = plugin.readme
				local entry = path.entry_to_file(readme, self.opts)
				return entry
			end
		end
	end

	return MyPreviewer
end

function M.lazy(opts)
	opts = opts or {}
	local fzf_lua = require("fzf-lua")

	local list = {}
	for _, plugin in ipairs(plugins) do
		table.insert(list, plugin.name)
	end

	opts.prompt = "Lazy❯ "
	opts.previewer = setupPreview()
	opts.actions = require("fzf-lua-lazy.actions").setup_mappings()

	return fzf_lua.fzf_exec(list, opts)
end

return M
