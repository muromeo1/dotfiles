return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/notes",
      },
    },
    picker = {
      name = "snacks.pick",
    },

    -- Save id as name.gsub.lower
    note_id_func = function(title)
      return title:gsub(" ", "-"):lower()
    end,
  },

  vim.keymap.set("n", "<leader>oo", ":Obsidian<CR>"),
  vim.keymap.set("n", "<leader>on", ":Obsidian new<CR>"),
  vim.keymap.set("n", "<leader>ot", ":Obsidian today<CR>"),
  vim.keymap.set("n", "<leader>oy", ":Obsidian yesterday<CR>"),

  -- Live grep
  vim.keymap.set("n", "<leader>of", ":Obsidian search<CR>", { desc = "Obsidian live grep" }),

  -- Search by file name
  vim.keymap.set("n", "<leader>os", function()
    Snacks.picker.files({
      cwd = "~/vaults/notes",
      dirs = { "~/vaults/notes" },
      follow = true,
    })
  end, { desc = "Obsidian search" }),
}
