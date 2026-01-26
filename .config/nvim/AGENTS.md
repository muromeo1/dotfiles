# Neovim Configuration - Agent Guidelines

This is a personal Neovim configuration based on LazyVim. It provides development environment setup for Ruby, Go, TypeScript, and embedded development (PlatformIO).

## Project Overview

**Type:** Neovim Configuration (LazyVim-based)
**Primary Language:** Lua
**Framework:** LazyVim with lazy.nvim plugin manager
**Theme:** Catppuccin

## Directory Structure

```
lua/
├── config/
│   ├── lazy.lua        # Lazy.nvim bootstrap and setup
│   ├── options.lua     # Neovim options (vim.opt overrides)
│   ├── keymaps.lua     # Custom keymaps (vim.keymap.set)
│   └── autocmds.lua    # Custom autocommands (vim.api.nvim_create_autocmd)
└── plugins/
    └── *.lua           # Plugin specs (one plugin per file recommended)
```

## Build/Lint/Test Commands

```bash
# Format Lua files with StyLua
stylua lua/

# Format single file
stylua lua/plugins/core.lua

# Check formatting without writing
stylua --check lua/

# Validate Lua syntax (requires luacheck)
luacheck lua/

# Open Neovim to test configuration
nvim --headless "+Lazy! sync" +qa
```

### In-Editor Commands

```vim
:Lazy              " Plugin management UI
:Lazy sync         " Update plugins to lockfile versions
:Lazy update       " Update plugins and lockfile
:checkhealth       " Run health checks for all plugins
:checkhealth lazy  " Check lazy.nvim specifically
```

### Testing (vim-test with vimux)

```vim
:TestNearest       " Run test under cursor
:TestFile          " Run current test file
:TestSuite         " Run entire test suite
:TestLast          " Re-run last test
:TestVisit         " Open last test file
```

## Code Style Guidelines

### Formatting (stylua.toml)

- **Indentation:** 2 spaces (no tabs)
- **Column width:** 120 characters
- **Quote style:** Double quotes (default)
- **Trailing commas:** Always in multiline tables

### File Naming

- Use lowercase with hyphens: `vim-test.lua`, `render-markdown.lua`
- Single descriptive name per plugin: `obsidian.lua`, `core.lua`
- Group related overrides in `core.lua`

### Plugin Spec Pattern

```lua
-- lua/plugins/example.lua
return {
  "author/plugin-name",
  dependencies = {
    "dep/one",
    "dep/two",
  },
  event = "VeryLazy",  -- or "BufReadPost", "InsertEnter", etc.
  opts = {
    setting = "value",
    nested = {
      option = true,
    },
  },
}
```

### Config Function Pattern

Use `opts` table when possible. Use `config` only when setup requires logic:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin").setup({
      setting = "value",
    })
    -- Additional setup after plugin loads
    vim.keymap.set("n", "<leader>x", ":Command<CR>", { desc = "Description" })
  end,
}
```

### Keymap Definitions

Prefer `keys` table in plugin specs for lazy-loading:

```lua
return {
  "author/plugin-name",
  keys = {
    { "<leader>xx", "<cmd>Command<cr>", desc = "Do something" },
    { "<leader>xy", function() print("hello") end, desc = "Function keymap" },
  },
}
```

For global keymaps in `lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>xx", ":Command<CR>", { desc = "Description" })
vim.keymap.set("n", "<leader>xy", function()
  -- Complex logic here
end, { desc = "Description" })
```

### LSP Server Configuration

```lua
-- In lua/plugins/core.lua or dedicated file
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruby_lsp = {
        -- Server-specific settings
        on_attach = function(client, bufnr)
          -- Customize on attach
        end,
      },
    },
  },
}
```

### Comments

```lua
-- Single line comment explaining why, not what

-- Multi-line comments for complex logic
-- that requires additional context
-- spanning several lines

-- Reference links to documentation:
-- https://www.lazyvim.org/configuration/plugins

-- Disable formatter for specific blocks:
-- stylua: ignore
local long_table = { "a", "b", "c", "d", "e" }
```

### Disabling Plugins

```lua
return {
  { "author/plugin-to-disable", enabled = false },
}
```

### Error Handling

- Use conditional checks for optional features:
  ```lua
  if not (vim.uv or vim.loop).fs_stat(path) then
    -- Handle missing path
  end
  ```
- Wrap risky operations in pcall:
  ```lua
  local ok, module = pcall(require, "optional-module")
  if ok then
    module.setup({})
  end
  ```

## Anti-Patterns to Avoid

- **Don't use tabs** - Always use 2 spaces
- **Don't exceed 120 columns** - Break long lines
- **Don't use `setup()` when `opts` works** - Prefer declarative config
- **Don't put multiple plugins in one file** - One plugin spec per file (except overrides)
- **Don't hardcode paths** - Use `vim.fn.stdpath()` or `vim.fs.joinpath()`
- **Don't ignore lazy-loading** - Use `event`, `cmd`, `keys`, or `ft` for performance

## LazyVim Conventions

This config extends LazyVim defaults. Key references:

- Default options: https://www.lazyvim.org/configuration/options
- Default keymaps: https://www.lazyvim.org/keymaps
- Plugin configuration: https://www.lazyvim.org/configuration/plugins
- Extras: https://www.lazyvim.org/extras

## Enabled LazyVim Extras

From `lazyvim.json`:
- `lazyvim.plugins.extras.ai.copilot`
- `lazyvim.plugins.extras.coding.luasnip`
- `lazyvim.plugins.extras.coding.mini-surround`
- `lazyvim.plugins.extras.dap.core`
- `lazyvim.plugins.extras.editor.fzf`
- `lazyvim.plugins.extras.editor.mini-move`
- `lazyvim.plugins.extras.formatting.prettier`
- `lazyvim.plugins.extras.lang.helm`
- `lazyvim.plugins.extras.lang.tailwind`
- `lazyvim.plugins.extras.linting.eslint`

## Quick Reference

| Task | Command/Pattern |
|------|-----------------|
| Add plugin | Create `lua/plugins/<name>.lua` with spec |
| Override plugin | Return spec with same plugin name |
| Disable plugin | `{ "plugin/name", enabled = false }` |
| Add keymap | `vim.keymap.set(mode, lhs, rhs, opts)` |
| Add option | Edit `lua/config/options.lua` |
| Format code | `stylua lua/` |
| Sync plugins | `:Lazy sync` in Neovim |
