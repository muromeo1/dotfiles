---@diagnostic disable: undefined-global
return {
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
          -- Show hidden files (files starting with .)
          hidden = false,
          -- Git integration - show untracked files
          git_status = true,
          git_untracked = true,
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
    dashboard = {
      preset = {
        pick = {},
        keys = {},
      },
    },
  },
}
