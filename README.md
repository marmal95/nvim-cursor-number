# Cursor-Number 💡

A small Neovim plugin that converts number under cursor into bin/dec/oct/hex number systems.

## Setup

```lua
require('cursor_number').setup()
```

With [lazy.nvim](https://github.com/folke/lazy.nvim/):

```lua
{
  'marmal95/nvim-cursor-number',
  cmd = { 'ConvertCursorNumber' },
  config = function(_, opts)
    require('cursor_number').setup(opts)
  end,
  opts = {}
}
```

## Configuration

Cursor-Number does not require any additional configuration.
