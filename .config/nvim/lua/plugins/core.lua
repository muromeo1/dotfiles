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
      picker = {
        sources = {
          explorer = {
            layout = {
              hidden = { "input" },
            },
            -- On open `nvim .` focus on the main window, not the tree
            on_show = function(picker)
              vim.schedule(function()
                if picker.main and vim.api.nvim_win_is_valid(picker.main) then
                  vim.api.nvim_set_current_win(picker.main)
                end
              end)
            end,
          },
        },
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
        "scss",
        "svelte",
        "typst",
        "vue",
      },
    },
  },
}
