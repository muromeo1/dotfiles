-- Use tab instead of enter to select completion
-- Use emoji completions
return {
  "saghen/blink.cmp",
  dependencies = { "allaman/emoji.nvim", "saghen/blink.compat" },
  opts = {
    keymap = {
      preset = "super-tab",
    },
    sources = {
      default = { "emoji" },
      providers = {
        emoji = {
          name = "emoji",
          module = "blink.compat.source",
          -- overwrite kind of suggestion
          transform_items = function(_, items)
            local kind = require("blink.cmp.types").CompletionItemKind.Text
            for i = 1, #items do
              items[i].kind = kind
            end
            return items
          end,
        },
      },
    },
  },
}
