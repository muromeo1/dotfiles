return {
  -- Catpuccin as main theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Use tab instead of enter to select completion
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },

  -- Disable flash.nvim, really annoying
  { "folke/flash.nvim", enabled = false },

  -- ruby-lsp config to not ovveride code highlighting
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        ruby_lsp = {
          on_attach = function(client, _)
            -- Disable semantic highlighting provided by ruby-lsp
            if client.server_capabilities.semanticTokensProvider then
              client.server_capabilities.semanticTokensProvider = nil
            end

            -- Disable document highlighting feature when put cursor on words
            if client.server_capabilities.documentHighlightProvider then
              client.server_capabilities.documentHighlightProvider = false
            end
          end,
        },
      },
    },
  },

  -- Disable snacks.nvim scroll animation
  -- Enable image preview
  {
    "folke/snacks.nvim",
    opts = {
      scroll = {
        enabled = false,
      },
      image = {
        enabled = true,
        backend = "kitty",
      },
    },
  },

  -- Ensure code highlight to ruby, go, js charts
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "go",
        "ruby",
        "css",
        "latex",
        "norg",
        "scss",
        "svelte",
        "typst",
        "vue",
        "norg`",
      },
    },
  },
}
