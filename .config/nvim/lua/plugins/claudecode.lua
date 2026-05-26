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
        width = 0.8,
        height = 0.9,
        border = "rounded",
        on_win = function(self)
          if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
            return
          end
          local line_count = vim.api.nvim_buf_line_count(self.buf)
          local first = vim.api.nvim_buf_get_lines(self.buf, 0, 1, false)[1] or ""
          if line_count <= 1 and first == "" then
            return
          end
          vim.defer_fn(function()
            if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
              local chan = vim.bo[self.buf].channel
              if chan and chan > 0 then
                vim.api.nvim_chan_send(chan, "\012")
              end
            end
          end, 50)
        end,
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
