# obsidian.nvim Configuration

## Plugin Repository

Use the community-maintained fork: `obsidian-nvim/obsidian.nvim` (not the original `epwalsh/obsidian.nvim`)

## Disable Footer Stats

The virtual text at the bottom of notes showing "0 backlinks  3 properties  6 words  27 chars" is controlled by the `footer` option (not `statusline`):

```lua
opts = {
  footer = {
    enabled = false,
  },
}
```

## Config Reference

- `footer` - Virtual text at bottom of notes (backlinks, properties, words, chars)
- `statusline` - Integration with statusline plugins (lualine, etc.)
- `ui` - Concealment features (checkboxes, bullets, etc.)
- `frontmatter` - YAML frontmatter handling

## Default Config

See: https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
