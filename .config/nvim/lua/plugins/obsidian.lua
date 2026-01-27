local vault = vim.fn.expand("~") .. "/vaults/notes"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = {
    "BufReadPre " .. vault .. "/**.md",
    "BufNewFile " .. vault .. "/**.md",
  },
  cmd = { "Obsidian" },
  keys = {
    { "<leader>Oo", "<cmd>Obsidian<cr>", desc = "Obsidian" },
    { "<leader>On", "<cmd>Obsidian new<cr>", desc = "Obsidian new" },
    { "<leader>Ot", "<cmd>Obsidian today<cr>", desc = "Obsidian today" },
    { "<leader>Oy", "<cmd>Obsidian yesterday<cr>", desc = "Obsidian yesterday" },
    { "<leader>Of", "<cmd>Obsidian search<cr>", desc = "Obsidian live grep" },
    {
      "<leader>Os",
      function()
        require("fzf-lua").files({ cwd = vault })
      end,
      desc = "Obsidian search files",
    },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "personal",
        path = vault,
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
}
