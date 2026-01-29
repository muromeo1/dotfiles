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
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        -- stylua: ignore
        keys = {
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "t", desc = "Today note", action = ":Obsidian today" },
          { icon = " ", key = "y", desc = "Yesterday note", action = ":Obsidian yesterday" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
