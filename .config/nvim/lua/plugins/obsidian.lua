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
      name = "fzf-lua",
    },

    -- Save id as name.gsub.lower
    note_id_func = function(title)
      return title:gsub(" ", "-"):lower()
    end,

    -- Disable UI features that hide checkbox text
    ui = {
      enable = false,
    },

    frontmatter = {
      enabled = false,
    },

    footer = {
      enabled = false,
    },
  },

  vim.keymap.set("n", "<leader>Oo", ":Obsidian<CR>"),
  vim.keymap.set("n", "<leader>On", ":Obsidian new<CR>"),
  vim.keymap.set("n", "<leader>Ot", ":Obsidian today<CR>"),
  vim.keymap.set("n", "<leader>Oy", ":Obsidian yesterday<CR>"),

  -- Live grep
  vim.keymap.set("n", "<leader>Of", ":Obsidian search<CR>", { desc = "Obsidian live grep" }),

  -- Search by file name
  vim.keymap.set("n", "<leader>Os", function()
    require("fzf-lua").files({
      cwd = "~/vaults/notes",
    })
  end, { desc = "Obsidian search" }),
}
