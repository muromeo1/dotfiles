return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.config.disable,
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-j>"] = cmp.mapping(function() end, { "i", "s" }),
      })
    end,
  },
  { "echasnovski/mini.pairs", enabled = false },
  { "folke/flash.nvim", enabled = false },
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
}
