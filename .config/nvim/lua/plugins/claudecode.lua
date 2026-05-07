local toggle_key = "<C-,>"

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  },
  opts = {
    focus_on_send = true,
    terminal = {
      snacks_win_opts = {
        position = "float",
        width = 190,
        height = 40,
        border = "rounded",
        keys = {
          claude_hide = {
            toggle_key,
            function(self)
              self:hide()
            end,
            mode = "t",
            desc = "Hide",
          },
          term_normal = { "<esc>", "<C-\\><C-n>", mode = "t", desc = "Normal mode" },
        },
      },
    },
    diff_opts = {
      keep_terminal_focus = true,
    },
  },
}
