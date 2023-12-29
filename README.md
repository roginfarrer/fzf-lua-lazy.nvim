# fzf-lua-lazy.nvim

[fzf-lua](https://github.com/ibhagwan/fzf-lua) extension that provides handy functionality about plugins installed via [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [lazy.nvim](https://github.com/folke/lazy.nvim)

## Installation

### Lazy

```lua
{ 'ibhagwan/fzf-lua', dependencies = 'roginfarrer/fzf-lua-lazy' }
```

## Usage

```lua
require('fzf-lua-lazy').search()
```

## Configuration

Setup is not required, but the configuration can extend the following defaults:

```lua
require('fzf-lua-lazy').setup({
  mappings = {
    open_readme = "default", -- i.e., Enter
    open_in_browser = "ctrl-o",
    open_in_find_files = "ctrl-f",
    open_in_live_grep = "ctrl-g",
    open_lazy_root_find_files = "ctrl-alt-f",
    open_lazy_root_live_grep = "ctrl-alt-g",
    change_cwd_to_plugin = "ctrl-alt-d",
  },
})
```

## Acknowledgements

This plugin was forked from [telescope-lazy.nvim](https://github.com/tsakirist/telescope-lazy.nvim) which provides similar functionality for Telescope.
